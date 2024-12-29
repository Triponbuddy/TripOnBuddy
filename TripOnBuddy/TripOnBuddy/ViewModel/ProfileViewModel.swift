//
//  ProfileViewModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import SwiftUI
import Firebase
import FirebaseAuth

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userPosts: [Post] = [] // Posts by the current user
    @Published var isLoading: Bool = false // Loading state
    @Published var errorMessage: String? = nil // Error message if fetching fails

    private let db = Firestore.firestore()

    func fetchUserPosts() async {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let snapshot = try await db.collection("posts")
                .whereField("userId", isEqualTo: currentUserId)
                .order(by: "timestamp", descending: true)
                .getDocuments()

            let posts = snapshot.documents.compactMap { doc -> Post? in
                let data = doc.data()
                print("Raw Firestore Data: \(data)") // Debugging
                return Post(id: doc.documentID, data: data)
            }
            self.userPosts = posts
        } catch {
            self.errorMessage = "Failed to fetch posts: \(error.localizedDescription)"
            print("Error fetching posts: \(error.localizedDescription)")
        }

        isLoading = false
    }

}

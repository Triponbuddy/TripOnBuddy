//
//  ProfileViewModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import SwiftUI
import Firebase
import FirebaseAuth

// ViewModel to handle user profile-related functionality, including fetching user posts
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userPosts: [Post] = []      // List of posts created by the current user
    @Published var isLoading: Bool = false    // Tracks if data is currently being loaded
    @Published var errorMessage: String? = nil // Holds an error message if an error occurs

    private let db = Firestore.firestore()    // Reference to Firestore database

    // Fetch all posts by the current user
    func fetchUserPosts() async {
        // Ensure the user is authenticated before proceeding
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated." // Error message if user is not logged in
            return
        }

        isLoading = true    // Start loading state
        errorMessage = nil  // Clear any previous error message

        do {
            // Query Firestore for posts by the current user, sorted by timestamp in descending order
            let snapshot = try await db.collection("posts")
                .whereField("userId", isEqualTo: currentUserId)
                .order(by: "timestamp", descending: true)
                .getDocuments()

            // Map Firestore documents to Post objects
            let posts = snapshot.documents.compactMap { doc -> Post? in
                let data = doc.data() // Get raw data from Firestore document
              //  print("Raw Firestore Data: \(data)") // Debugging: Print the raw Firestore data
                return Post(id: doc.documentID, data: data) // Convert data to a Post object
            }
            self.userPosts = posts // Update the published userPosts property with fetched posts
        } catch {
            // Handle errors by setting the error message
            self.errorMessage = "Failed to fetch posts: \(error.localizedDescription)"
            print("Error fetching posts: \(error.localizedDescription)") // Debugging: Log the error
        }

        isLoading = false // End loading state
    }
}

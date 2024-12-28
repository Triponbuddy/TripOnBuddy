//
//  Authentication.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-17.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SwiftUICore

// Protocol to validate authentication forms
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get } // Ensures form validity check
}

// ViewModel to handle authentication and user management
@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? // Stores the currently signed-in user session
    @Published var currentUser: User? // Stores the current user's profile data

    // Initialize ViewModel and fetch user data if already logged in
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }

    // Sign in user with email and password
    func signIN(withEmail email: String, password: String) async throws {
        do {
            // Authenticate user with Firebase
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user // Update session state
            
            await fetchUser() // Fetch and load user profile data
            
        } catch {
            print("DEBUG: Failed to Sign In the user with error: \(error.localizedDescription)")
        }
    }

    // Create a new user with email, password, full name, and username
    func createUser(withEmail email: String, password: String, fullName: String, username: String, image: UIImage?) async throws {
        do {
            // Create a new user in Firebase Authentication
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user // Update session state
            
            var profileImageUrl: String? = nil
            
            // Upload profile image if provided
            if let image = image {
                let result = try await withCheckedThrowingContinuation { continuation in
                    uploadProfileImage(image: image) { result in
                        continuation.resume(with: result)
                    }
                }
                profileImageUrl = result // Get image URL
            }

            // Create a user object to store in Firestore
            let user = User(
                id: result.user.uid,
                userName: username,
                fullName: fullName,
                userImage: profileImageUrl,
                emailId: email
            )

            // Encode user data and save to Firestore
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser() // Fetch and load user profile data
            
        } catch {
            print("DEBUG: Failed to Create user with error: \(error.localizedDescription)")
        }
    }

    // Sign out the current user
    func signOut() {
        do {
            try Auth.auth().signOut() // Sign out from Firebase
            self.userSession = nil  // Clear session state
            self.currentUser = nil  // Clear user data
        }
        catch {
            print("DEBUG: Failed to Sign Out the user with error: \(error.localizedDescription)")
        }
    }

    // Delete the current user account along with their data
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else { return }

        do {
            // Delete user data from Firestore
            let userDocRef = Firestore.firestore().collection("users").document(user.uid)
            try await userDocRef.delete()
            print("DEBUG: User data deleted from Firestore")

            // Delete user account from Firebase Authentication
            try await user.delete()
            print("DEBUG: User account deleted successfully")
            
            // Clear session and user data
            self.userSession = nil
            self.currentUser = nil

        } catch {
            print("DEBUG: Error deleting account - \(error.localizedDescription)")
        }
    }

    // Fetch the current user's profile data from Firestore
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            // Decode and load user data if it exists
            if let data = snapshot.data() {
                self.currentUser = try Firestore.Decoder().decode(User.self, from: data)
                print("DEBUG: Current User is \(String(describing: self.currentUser))")
            } else {
                print("DEBUG: No user data found for uid \(uid)")
            }
        } catch {
            print("DEBUG: Error fetching user: \(error.localizedDescription)")
        }
    }

    // Uploads a profile image to Firebase Storage
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        // Convert image to JPEG format with compression
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        // Generate a unique filename for the image
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "profile_images/\(filename)")
        
        // Upload image data to Firebase Storage
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error)) // Handle upload failure
                return
            }
            
            // Retrieve and return the download URL for the image
            ref.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error)) // Handle URL retrieval failure
                    return
                }
                
                guard let url = url?.absoluteString else {
                    completion(.failure(NSError(domain: "UploadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get URL"])))
                    return
                }
                
                completion(.success(url)) // Return image URL on success
            }
        }
    }
}

//
//  DataServices.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 24/03/24.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import Foundation

// Service class to handle all data-related operations (Firestore and Firebase Storage)
class DataServices {
    private let db = Firestore.firestore()        // Firestore database reference
    private let storage = Storage.storage().reference() // Firebase Storage reference

    // Fetch posts for a specific user from Firestore
    func fetchPosts(for userId: String) async throws -> [Post] {
        // Query Firestore for posts where userId matches the given userId
        let snapshot = try await db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()

        // Map Firestore documents to Post objects
        return snapshot.documents.compactMap { doc -> Post? in
            try? doc.data(as: Post.self) // Decode document data into Post
        }
    }

    // Upload an image to Firebase Storage and return the download URL
    func uploadImage(_ image: UIImage, userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Convert the UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            // Handle error if image conversion fails
            completion(.failure(NSError(domain: "InvalidImage", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data."])))
            return
        }

        // Generate a unique identifier for the image
        let imageId = UUID().uuidString
        let storagePath = "posts/\(userId)/\(imageId).jpg"

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // Upload the image data to Firebase Storage
        let uploadTask = storage.child(storagePath).putData(imageData, metadata: metadata)

        // Observe successful upload and fetch the download URL
        uploadTask.observe(.success) { _ in
            self.storage.child(storagePath).downloadURL { url, error in
                if let error = error {
                    completion(.failure(error)) // Handle error fetching URL
                } else if let url = url {
                    completion(.success(url.absoluteString)) // Return the download URL
                }
            }
        }

        // Observe upload failure
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completion(.failure(error)) // Handle upload error
            }
        }
    }

    // Create a new post and add it to Firestore
    func createPost(userId: String, post: Post, completion: @escaping (Bool) -> Void) {
        do {
            // Generate a unique identifier for the post
            let postId = UUID().uuidString
            // Encode the Post object into a Firestore-compatible dictionary
            let encodedPost = try Firestore.Encoder().encode(post)
            
            // Save the encoded post data to Firestore
            db.collection("posts").document(postId).setData(encodedPost) { error in
                completion(error == nil) // Completion handler returns true if no error
            }
        } catch {
            completion(false) // Completion handler returns false if encoding fails
        }
    }

    // Fetch user details from Firestore
    func fetchUser(userId: String) async throws -> User {
        // Get the Firestore document for the given userId
        let snapshot = try await db.collection("users").document(userId).getDocument()
        
        // Ensure the document contains data
        guard let data = snapshot.data() else {
            throw NSError(domain: "UserNotFound", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data not found."])
        }

        // Decode the Firestore data into a User object
        return try Firestore.Decoder().decode(User.self, from: data)
    }
}

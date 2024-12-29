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

class DataServices {
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()

    // Fetch posts for a specific user
    func fetchPosts(for userId: String) async throws -> [Post] {
        let snapshot = try await db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()

        return snapshot.documents.compactMap { doc -> Post? in
            try? doc.data(as: Post.self)
        }
    }

    // Upload an image to Firebase Storage
    func uploadImage(_ image: UIImage, userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "InvalidImage", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data."])))
            return
        }

        let imageId = UUID().uuidString
        let storagePath = "posts/\(userId)/\(imageId).jpg"

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let uploadTask = storage.child(storagePath).putData(imageData, metadata: metadata)

        uploadTask.observe(.success) { _ in
            self.storage.child(storagePath).downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }

        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completion(.failure(error))
            }
        }
    }

    // Add a post to Firestore
    func createPost(userId: String, post: Post, completion: @escaping (Bool) -> Void) {
        do {
            let postId = UUID().uuidString
            let encodedPost = try Firestore.Encoder().encode(post)
            db.collection("posts").document(postId).setData(encodedPost) { error in
                completion(error == nil)
            }
        } catch {
            completion(false)
        }
    }

    // Fetch user details
    func fetchUser(userId: String) async throws -> User {
        let snapshot = try await db.collection("users").document(userId).getDocument()
        guard let data = snapshot.data() else {
            throw NSError(domain: "UserNotFound", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data not found."])
        }
        return try Firestore.Decoder().decode(User.self, from: data)
    }
}

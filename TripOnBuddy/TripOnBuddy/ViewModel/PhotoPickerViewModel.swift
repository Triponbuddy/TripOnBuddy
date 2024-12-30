//
//  PhotoPickerViewModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

// ViewModel for managing photo selection and upload functionality
final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil // Holds the selected image
    @Published var imageSelection: PhotosPickerItem? = nil {  // Tracks the selected photo picker item
        didSet {
            setImage(from: imageSelection) // Updates the selected image whenever a new photo is picked
        }
    }

    // Load the selected image from the PhotosPickerItem
    func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return } // Ensure a valid selection exists
        
        Task {
            // Attempt to load the image data
            if let data = try? await selection.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage // Set the selected image
            }
        }
    }

    // Upload an image to Firebase Storage and get its download URL
    func uploadPostImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        // Convert the UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        // Generate a unique filename for the image
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "post_images/\(filename)")

        // Upload the image data to Firebase Storage
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error)) // Handle upload failure
                return
            }
            
            // Fetch the download URL for the uploaded image
            ref.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error)) // Handle error fetching URL
                } else if let url = url?.absoluteString {
                    completion(.success(url)) // Return the download URL
                }
            }
        }
    }

    // Save the post data (image URL, caption, and user info) to Firestore
    func savePost(imageUrl: String, caption: String, user: User) {
        let db = Firestore.firestore() // Reference to Firestore database
        
        // Create a new post object
        let newPost = Post(
            id: UUID().uuidString,        // Generate unique ID for the post
            userName: user.userName,      // Use the user's username
            fullName: user.fullName,      // Use the user's full name
            imageUrl: imageUrl,           // URL of the uploaded image
            caption: caption              // Caption for the post
        )
        
        // Save the post to Firestore
        db.collection("posts").document(newPost.id).setData(newPost.asDictionary()) { error in
            if let error = error {
                print("Error saving post: \(error.localizedDescription)") // Log error
            } else {
                print("Post successfully saved!") // Confirm success
            }
        }
    }
}

// Extension for additional post-related functionality
extension PhotoPickerViewModel {
    // Upload a post with a caption to Firestore
    func uploadPost(caption: String, completion: @escaping (Error?) -> Void) {
        guard let selectedImage = selectedImage else { return } // Ensure an image is selected

        // Upload the image to Firebase Storage
        uploadPostImage(selectedImage) { result in
            switch result {
            case .success(let imageUrl):
                // Prepare post data for Firestore
                let postId = UUID().uuidString
                let postData: [String: Any] = [
                    "id": postId,          // Unique post ID
                    "userName": "",        // Replace with actual user data
                    "fullName": "",        // Replace with actual user data
                    "mediaUrl": imageUrl,  // URL of the uploaded image
                    "caption": caption     // Caption for the post
                ]

                // Save the post data to Firestore
                let db = Firestore.firestore()
                db.collection("posts").document(postId).setData(postData) { error in
                    completion(error) // Call the completion handler with any error
                }

            case .failure(let error):
                completion(error) // Handle upload error
            }
        }
    }
}

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

final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }

    func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }

    // Upload Post Image to Firebase Storage
    func uploadPostImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "post_images/\(filename)")

        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            ref.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url?.absoluteString {
                    completion(.success(url))
                }
            }
        }
    }
    func savePost(imageUrl: String, caption: String, user: User) {
        let db = Firestore.firestore()
        
        // Create a new Post using User details
        let newPost = Post(
            id: UUID().uuidString,
            userName: user.userName,  // Using username
            fullName: user.fullName,  // Using full name
            imageUrl: imageUrl,
            caption: caption
        )
        
        // Save to Firestore
        db.collection("posts").document(newPost.id).setData(newPost.asDictionary()) { error in
            if let error = error {
                print("Error saving post: \(error.localizedDescription)")
            } else {
                print("Post successfully saved!")
            }
        }
    }
}

extension PhotoPickerViewModel {
    func uploadPost(caption: String, completion: @escaping (Error?) -> Void) {
        guard let selectedImage = selectedImage else { return }

        uploadPostImage(selectedImage) { result in
            switch result {
            case .success(let imageUrl):
                let postId = UUID().uuidString
                let postData: [String: Any] = [
                    "id": postId,
                    "userName": "", // Replace with actual user data
                    "fullName": "", // Replace with actual user data
                    "mediaUrl": imageUrl,
                    "caption": caption
                ]

                let db = Firestore.firestore()
                db.collection("posts").document(postId).setData(postData) { error in
                    completion(error)
                }

            case .failure(let error):
                completion(error)
            }
        }
    }
}

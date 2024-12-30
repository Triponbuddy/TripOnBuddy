//
//  PostViewModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import Photos
import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

// ViewModel to handle post creation, media upload, and fetching media from the gallery
class PostViewModel: ObservableObject {
    @Published var galleryImages: [UIImage] = []       // List of images from the gallery
    @Published var galleryVideos: [PHAsset] = []      // List of videos from the gallery
    @Published var selectedImage: UIImage? = nil      // Selected image for the post
    @Published var selectedVideoURL: URL? = nil       // Selected video URL for the post
    @Published var caption: String = ""              // Caption for the post

    private let storage = Storage.storage().reference()  // Firebase Storage reference
    private let db = Firestore.firestore()              // Firestore database reference

    // Sets to track added assets and avoid duplicates
    private var addedImageAssets: Set<String> = []
    private var addedVideoAssets: Set<String> = []

    // Fetch media (images and videos) from the user's gallery
    func fetchGalleryMedia() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // Sort by newest first

        // Fetch Images
        let fetchImages = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        fetchImages.enumerateObjects { asset, _, _ in
            let assetId = asset.localIdentifier
            guard !self.addedImageAssets.contains(assetId) else { return } // Skip duplicates
            self.addedImageAssets.insert(assetId)
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true

            // Request the image data from the asset
            PHImageManager.default().requestImage(for: asset,
                                                  targetSize: CGSize(width: 1920, height: 1080),
                                                  contentMode: .aspectFill,
                                                  options: requestOptions) { [weak self] image, _ in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async {
                    self.galleryImages.append(image)       // Add image to the gallery list
                    if self.selectedImage == nil {
                        self.selectedImage = image        // Set the first image as the selected image
                    }
                }
            }
        }

        // Fetch Videos
        let fetchVideos = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        fetchVideos.enumerateObjects { asset, _, _ in
            let assetId = asset.localIdentifier
            guard !self.addedVideoAssets.contains(assetId) else { return } // Skip duplicates
            self.addedVideoAssets.insert(assetId)
            
            DispatchQueue.main.async {
                self.galleryVideos.append(asset)         // Add video asset to the gallery list
            }
        }
    }

    // Upload an image post to Firebase Storage and Firestore
    func uploadMediaPost(image: UIImage, userName: String, fullName: String, caption: String, completion: @escaping (Bool) -> Void) async {
        guard let currentUser = Auth.auth().currentUser else {
            print("Error: User is not authenticated.") // Ensure user is logged in
            completion(false)
            return
        }

        let postId = UUID().uuidString                             // Generate a unique post ID
        let storagePath = "posts/\(currentUser.uid)/\(postId).jpg" // Path in Firebase Storage
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Error: Unable to convert image to JPEG data.")  // Ensure image can be converted to JPEG
            completion(false)
            return
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        do {
            // Upload image to Firebase Storage
            let storageReference = storage.child(storagePath)
            let _ = try await storageReference.putDataAsync(imageData, metadata: metadata)

            // Fetch the image's download URL
            let mediaUrl = try await storageReference.downloadURL()

            // Prepare the post data
            let post: [String: Any] = [
                "userId": currentUser.uid,
                "userName": userName,
                "fullName": fullName,
                "mediaUrl": mediaUrl.absoluteString,
                "caption": caption,
                "timestamp": Timestamp()
            ]

            // Save the post data to Firestore
            try await db.collection("posts").document(postId).setData(post)
            print("Post successfully uploaded: \(post)")
            completion(true)
        } catch let storageError as NSError {
            print("Error uploading post: \(storageError.localizedDescription)")
            completion(false)
        } catch {
            print("Unknown error occurred: \(error.localizedDescription)")
            completion(false)
        }
    }

    // Handle upload progress and save post details to Firestore
    private func handleUpload(uploadTask: StorageUploadTask, storagePath: String, currentUser: FirebaseAuth.User, postId: String, completion: @escaping (Bool) -> Void) {
        // Observe successful upload
        uploadTask.observe(.success) { [weak self] _ in
            self?.storage.child(storagePath).downloadURL { url, error in
                guard let self = self, let url = url, error == nil else {
                    completion(false)
                    return
                }

                // Fetch user details from Firestore
                self.db.collection("users").document(currentUser.uid).getDocument { snapshot, error in
                    guard let data = snapshot?.data(), error == nil else {
                        completion(false)
                        return
                    }

                    // Extract user details
                    let userName = data["userName"] as? String ?? "AnonymousUser"
                    let fullName = data["fullName"] as? String ?? "AnonymousName"

                    // Prepare post data
                    let post: [String: Any] = [
                        "userId": currentUser.uid,
                        "userName": userName,
                        "fullName": fullName,
                        "mediaUrl": url.absoluteString,
                        "caption": self.caption,
                        "timestamp": Timestamp()
                    ]

                    // Save post to Firestore
                    self.db.collection("posts").document(postId).setData(post) { error in
                        completion(error == nil)
                    }
                }
            }
        }

        // Observe upload failure
        uploadTask.observe(.failure) { _ in
            completion(false)
        }
    }
}

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

class PostViewModel: ObservableObject {
    @Published var galleryImages: [UIImage] = []
    @Published var galleryVideos: [PHAsset] = []
    @Published var selectedImage: UIImage? = nil
    @Published var selectedVideoURL: URL? = nil
    @Published var caption: String = ""
    
    private let storage = Storage.storage().reference()
    private let db = Firestore.firestore()
    
    // Track added assets to avoid duplicates
    private var addedImageAssets: Set<String> = []
    private var addedVideoAssets: Set<String> = []
    
    func fetchGalleryMedia() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Fetch Images
        let fetchImages = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        fetchImages.enumerateObjects { asset, _, _ in
            let assetId = asset.localIdentifier
            guard !self.addedImageAssets.contains(assetId) else { return } // Skip duplicates
            self.addedImageAssets.insert(assetId)
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            
            PHImageManager.default().requestImage(for: asset,
                                                  targetSize: CGSize(width: 1920, height: 1080),
                                                  contentMode: .aspectFill,
                                                  options: requestOptions) { [weak self] image, _ in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async {
                    self.galleryImages.append(image)
                    if self.selectedImage == nil {
                        self.selectedImage = image // Set most recent image
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
                self.galleryVideos.append(asset)
            }
        }
    }
    
    func uploadMediaPost(image: UIImage, userName: String, fullName: String, caption: String, completion: @escaping (Bool) -> Void) async {
        guard let currentUser = Auth.auth().currentUser else {
            print("Error: User is not authenticated.")
            completion(false)
            return
        }

        let postId = UUID().uuidString
        let storagePath = "posts/\(currentUser.uid)/\(postId).jpg"
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Error: Unable to convert image to JPEG data.")
            completion(false)
            return
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        do {
            let storageReference = storage.child(storagePath)
            let _ = try await storageReference.putDataAsync(imageData, metadata: metadata) // Upload image
            let mediaUrl = try await storageReference.downloadURL() // Get URL

            let post: [String: Any] = [
                "userId": currentUser.uid,
                "userName": userName,
                "fullName": fullName,
                "mediaUrl": mediaUrl.absoluteString,
                "caption": caption,
                "timestamp": Timestamp()
            ]

            try await db.collection("posts").document(postId).setData(post) // Save post
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

    
    
    // Helper Function to Handle the Upload and Firestore Integration
    private func handleUpload(uploadTask: StorageUploadTask, storagePath: String, currentUser: FirebaseAuth.User, postId: String, completion: @escaping (Bool) -> Void) {
        uploadTask.observe(.success) { [weak self] _ in
            self?.storage.child(storagePath).downloadURL { url, error in
                guard let self = self, let url = url, error == nil else {
                    completion(false)
                    return
                }
                
                // Fetch additional user details from Firestore
                self.db.collection("users").document(currentUser.uid).getDocument { snapshot, error in
                    guard let data = snapshot?.data(), error == nil else {
                        completion(false)
                        return
                    }
                    
                    // Extract user details
                    let userName = data["userName"] as? String ?? "AnonymousUser"
                    let fullName = data["fullName"] as? String ?? "AnonymousName"
                    
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
        
        uploadTask.observe(.failure) { _ in
            completion(false)
        }
    }
}

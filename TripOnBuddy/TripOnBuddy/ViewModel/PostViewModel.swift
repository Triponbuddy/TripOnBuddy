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
    @Published var galleryImages: [UIImage] = [] // List of gallery images
    @Published var galleryVideos: [PHAsset] = [] // List of video assets
    @Published var selectedImage: UIImage? = nil // Currently selected image
    @Published var selectedVideoURL: URL? = nil // Currently selected video URL
    @Published var caption: String = "" // Post caption
    @Published var isFetching: Bool = false // Track if fetching is in progress

    private let storage = Storage.storage().reference() // Firebase storage reference
    private let db = Firestore.firestore() // Firestore reference
    private var addedImageAssets: Set<String> = [] // Track added images to avoid duplicates
    private let batchSize = 30 // Limit of images fetched per batch
    private var lastFetchedIndex: Int = 0 // Tracks the index of the last fetched image

    // Fetch media from the gallery
    func fetchGalleryMedia() {
        guard !isFetching else { return }
        isFetching = true

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let allImages = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            let startIndex = self.lastFetchedIndex
            let endIndex = min(startIndex + self.batchSize, allImages.count)

            for index in startIndex..<endIndex {
                let asset = allImages.object(at: index)
                self.requestHighQualityImage(for: asset)
            }

            DispatchQueue.main.async {
                self.lastFetchedIndex = endIndex
                self.isFetching = false
            }
        }
    }

    // Request a high-quality image for a given PHAsset
    private func requestHighQualityImage(for asset: PHAsset) {
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.resizeMode = .exact
        requestOptions.isSynchronous = false

        let targetSize = CGSize(width: 1920, height: 1080) // Full HD resolution

        PHImageManager.default().requestImage(
            for: asset,
            targetSize: targetSize,
            contentMode: .aspectFit,
            options: requestOptions
        ) { [weak self] image, info in
            DispatchQueue.main.async {
                guard let self = self, let image = image, !(info?[PHImageResultIsDegradedKey] as? Bool ?? false) else { return }
                self.galleryImages.append(image)
                if self.selectedImage == nil {
                    self.selectedImage = image
                }
            }
        }
    }

    // Upload an image post
    func uploadMediaPost(image: UIImage, userName: String, fullName: String, caption: String, completion: @escaping (Bool) -> Void) async {
        guard let currentUser = Auth.auth().currentUser else {
            print("Error: User not authenticated.")
            completion(false)
            return
        }

        let postId = UUID().uuidString
        let storagePath = "posts/\(currentUser.uid)/\(postId).jpg"

        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: Unable to convert image to JPEG data.")
            completion(false)
            return
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        do {
            let storageReference = storage.child(storagePath)
            let _ = try await storageReference.putDataAsync(imageData, metadata: metadata)

            let mediaUrl = try await storageReference.downloadURL()

            let post: [String: Any] = [
                "userId": currentUser.uid,
                "userName": userName,
                "fullName": fullName,
                "mediaUrl": mediaUrl.absoluteString,
                "caption": caption,
                "timestamp": Timestamp()
            ]

            try await db.collection("posts").document(postId).setData(post)
            print("Post successfully uploaded: \(post)")
            completion(true)
        } catch let error as NSError {
            print("Error uploading post: \(error.localizedDescription)")
            completion(false)
        }
    }

    // Clear gallery cache
    func clearCache() {
        galleryImages.removeAll()
        galleryVideos.removeAll()
        lastFetchedIndex = 0
    }
}

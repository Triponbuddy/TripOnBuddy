//
//  PostView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

struct PostView: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    @State var jumpToAddCaptionView: Bool = false
    @State var posts: [Post] = []
    @State var selectedImage: UIImage? = nil
    @State private var recentImage: UIImage? = nil
    @State private var galleryImages: [UIImage] = []
    @State var aspectRatio: ContentMode = .fit
    
    var body: some View {
        
        NavigationStack {
            VStack {
                // Top View: Recent Image
                if let recentImage = selectedImage ?? recentImage {
                    Image(uiImage: recentImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height / 3)
                        .clipped()
                        .onTapGesture {
                            selectedImage = recentImage
                            jumpToAddCaptionView = true
                        }
                } else {
                    Text("No images available")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                // Grid of Gallery Images
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 10) {
                        ForEach(galleryImages, id: \..self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width / 2 - 10, height: UIScreen.main.bounds.width / 2 - 10)
                                .clipped()
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedImage = image
                                }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            .onAppear {
                fetchGalleryImages()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink(destination: AddCaptionViewToPost(selectedImage: selectedImage!)) {
                        Text("Next")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                }
            }
        }
    }
    func fetchGalleryImages() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let imageManager = PHImageManager.default()
        
        fetchResult.enumerateObjects { asset, _, _ in
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            
            imageManager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions) { image, _ in
                if let image = image {
                    galleryImages.append(image)
                }
                if recentImage == nil {
                    recentImage = galleryImages.first
                }
            }
        }
    }
}



#Preview {
    PostView()
}

//
//  GalleryGridViewForPhotos.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-31.
//

import SwiftUI

struct GalleryGridViewForPhotos: View {
    @StateObject var postViewModel = PostViewModel()
    @State var isSelected: Bool = false
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)], spacing: 3) {
                ForEach(postViewModel.galleryImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 4) + 26, height: (UIScreen.main.bounds.width / 3) - 3)
                        .cornerRadius(3)
                        .onTapGesture {
                            postViewModel.selectedImage = image
                        }
                    
                }
            }
            .padding(0)
        }
        .onAppear {
            postViewModel.fetchGalleryMedia()
        }
    }
}

#Preview {
    GalleryGridViewForPhotos()
}

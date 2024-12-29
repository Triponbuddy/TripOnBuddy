//
//  PostView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var authViewModel: AuthViewModel // To access user info
    @StateObject private var postViewModel = PostViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if let selectedImage = postViewModel.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height / 3)
                        .clipped()
                } else {
                    Text("Select an image to upload")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(height: UIScreen.main.bounds.height / 3)
                }

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(postViewModel.galleryImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipped()
                                .cornerRadius(6)
                                .onTapGesture {
                                    postViewModel.selectedImage = image
                                }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                postViewModel.fetchGalleryMedia()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let selectedImage = postViewModel.selectedImage,
                       let currentUser = authViewModel.currentUser {
                        NavigationLink(
                            "Next",
                            destination: AddCaptionViewToPost(
                                selectedImage: selectedImage,
                                userName: currentUser.userName,
                                fullName: currentUser.fullName
                            )
                            .environmentObject(postViewModel)
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    PostView()
}

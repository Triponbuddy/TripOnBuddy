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
                        .frame(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height / 3)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } else {
                    Text("Select an image to upload")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(height: UIScreen.main.bounds.height / 3)
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)], spacing: 3) {
                        ForEach(postViewModel.galleryImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (UIScreen.main.bounds.width / 4) + 26, height: (UIScreen.main.bounds.width / 3) - 3)
                                    .clipped()
                                    .cornerRadius(3)
                                    .onTapGesture {
                                        postViewModel.selectedImage = image
                                    }
                            }
                    }
                    .padding(0)
                }
                
            }
            .padding(.horizontal, 8)
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

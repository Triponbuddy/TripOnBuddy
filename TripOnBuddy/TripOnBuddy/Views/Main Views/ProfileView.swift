//
//  ProfileView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel // For user authentication
    @StateObject private var viewModel = ProfileViewModel() // ViewModel for Profile

    var body: some View {
        NavigationStack {
            VStack {
                if let user = authViewModel.currentUser {
                    // User Info Section
                    userInfoSection(user: user)

                    Divider()

                    // User Posts Section
                    userPostsSection
                } else {
                    Text("Please log in to view your profile.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                Task {
                    await viewModel.fetchUserPosts()
                }
            }
        }
    }

    @ViewBuilder
    private func userInfoSection(user: User) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: user.userImage ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullName)
                        .font(.headline)
                    Text("@\(user.userName)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(user.bio ?? "No bio available.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            Button("Sign Out") {
                authViewModel.signOut()
            }
            .foregroundColor(.red)
        }
        .padding()
    }

    @ViewBuilder
    private var userPostsSection: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading posts...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if viewModel.userPosts.isEmpty {
                Text("You haven't posted anything yet.")
                    .foregroundColor(.gray)
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.userPosts) { post in
                        SinglePostView(post: post)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}

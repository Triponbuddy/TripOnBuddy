//
//  ProfileView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

// View displaying the user's profile, including personal details and posts
struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel // ViewModel for authentication
    @StateObject private var viewModel = ProfileViewModel() // ViewModel for managing profile data

    var body: some View {
        NavigationStack {
            VStack {
                // Header Section: Profile Picture, Name, and Stats
                HStack {
                    
                    if let user = authViewModel.currentUser {
                        VStack(alignment: .leading, spacing: 6) {
                            // Profile Picture Placeholder
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)

                            // Full Name
                            Text(user.fullName)
                                .font(.system(size: 16))

                            // Username
                            Text("@\(user.userName)")
                                .font(.system(size: 14))

                            // User Bio
                            Text(user.bio ?? "")
                                .font(.system(size: 16))
                        }
                        .padding(.top, 10)
                    }
                    

                    Spacer()

                    // Buddies Count (Placeholder for now)
                    VStack {
                        Text("0") // Replace with actual count in the future
                            .bold()
                        Text("Buddies")
                    }

                    Spacer()
                }

                Spacer()

                // Sign Out Button
                Button("Sign Out") {
                    authViewModel.signOut()
                }

                // Posts Section
                ScrollView {
                    if viewModel.isLoading {
                        // Show a loading indicator if posts are being fetched
                        ProgressView("Loading posts...")
                    } else if viewModel.errorMessage != nil {
                        // Show an error message if post retrieval fails
                        Text("Can't retrieve Posts")
                            .foregroundColor(.red)
                    } else if viewModel.userPosts.isEmpty {
                        // Show a message if there are no posts
                        Text("You haven't posted anything yet.")
                            .foregroundColor(.gray)
                    } else {
                        // Display posts in a grid layout
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 0),
                                GridItem(.flexible(), spacing: 0),
                                GridItem(.flexible(), spacing: 0)
                            ],
                            spacing: 2
                        ) {
                            ForEach(viewModel.userPosts) { post in
                                // Display each post as an AsyncImage
                                AsyncImage(url: URL(string: post.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipped()
                                } placeholder: {
                                    // Placeholder while the image loads
                                }
                            }
                        }
                    }
                }
            }
            // Toolbar Section
            .toolbar(content: {
                // Leading Toolbar Item: Display Username
                ToolbarItem(placement: .topBarLeading) {
                    Text(authViewModel.currentUser?.userName.capitalized ?? "TripOnBuddy")
                        .font(.title)
                        .bold()
                }

                // Trailing Toolbar Item: Menu Icon (placeholder for settings or menu)
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "line.3.horizontal")
                }
            })
            .onAppear {
                
                // Fetch user posts when the view appears
                Task {
                     
                    await viewModel.fetchUserPosts()
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel()) // Provide the AuthViewModel for testing
}

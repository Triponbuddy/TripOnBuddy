//
//  AddCaptionViewToPost.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import SwiftUI
import Firebase

// A view to add a caption to a selected image before posting
struct AddCaptionViewToPost: View {
    let selectedImage: UIImage      // The image selected by the user
    let userName: String            // The username of the current user
    let fullName: String            // The full name of the current user

    @State private var caption: String = "" // State variable to store the caption input
    @EnvironmentObject var postViewModel: PostViewModel // Access the PostViewModel for handling posts
    @Environment(\.dismiss) var dismiss   // Dismiss the view when the user goes back

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Display the user's full name
                    HStack {
                        Text(fullName.capitalized)
                            .font(.headline)
                        Spacer()
                    }
                    ScrollView {
                        // Display the selected image
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 10, height: 350)
                            .cornerRadius(10)
                            .padding(5)
                        
                        Divider() // Add a divider for visual separation
                        
                        // Caption input field
                        TextField("Add a caption...", text: $caption, axis: .vertical)
                            .padding()
                            .lineLimit(0...100) // Allow up to 100 lines of caption
                    }
                    Spacer() // Push content to the top
                }
                .padding(.horizontal, 8) // Add padding to the horizontal edges
                .toolbar {
                    // Back button in the toolbar
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss() // Dismiss the view
                        }) {
                            Image(systemName: "chevron.left")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.nileBlue) // Custom color
                        }
                    }
                    
                    // Post button in the toolbar
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            Task {
                                // Trigger the post upload action
                                await postViewModel.uploadMediaPost(
                                    image: selectedImage,
                                    userName: userName,
                                    fullName: fullName,
                                    caption: caption
                                ) { success in
                                    if success {
                                        print("Post uploaded successfully.") // Log success
                                        DispatchQueue.main.async {
                                            dismiss() // Dismiss the view after successful upload
                                        }
                                    } else {
                                        print("Failed to upload post.") // Log failure
                                    }
                                }
                            }
                        }) {
                            Text("Post")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.nileBlue) // Custom color
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
}

#Preview {
    AddCaptionViewToPost(
        selectedImage: .demo, // Demo image for preview purposes
        userName: "example",
        fullName: "Sunil Sharma"
    )
}

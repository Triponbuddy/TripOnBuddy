//
//  AddCaptionViewToPost.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import SwiftUI
import Firebase

struct AddCaptionViewToPost: View {
    let selectedImage: UIImage
    let userName: String
    let fullName: String
    
    @State private var caption: String = ""
    @EnvironmentObject var postViewModel: PostViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
            
            TextField("Add a caption...", text: $caption)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                Task {
                    await postViewModel.uploadMediaPost(
                        image: selectedImage,
                        userName: userName,
                        fullName: fullName,
                        caption: caption
                    ) { success in
                        if success {
                            print("Post uploaded successfully.")
                            DispatchQueue.main.async {
                                dismiss()
                            }
                        } else {
                            print("Failed to upload post.")
                        }
                    }
                }
            }) {
                Text("Post")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
    
}


#Preview {
    AddCaptionViewToPost(selectedImage: .TOB, userName: "example", fullName: "Sunil Sharma" )
}

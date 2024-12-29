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
    @State private var caption: String = ""
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
                savePostToFirestore()
                dismiss()
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
    
    func savePostToFirestore() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let post = Post(
            id: UUID().uuidString,
            userName: currentUser.displayName ?? "Anonymous",
            fullName: currentUser.displayName ?? "Anonymous",
            imageUrl: "URL_placeholder", // Replace with image upload logic
            caption: caption
        )
        
        db.collection("posts").document(post.id).setData(post.asDictionary()) { error in
            if let error = error {
                print("Error saving post: \(error.localizedDescription)")
            } else {
                print("Post successfully saved!")
            }
        }
    }
}


#Preview {
    AddCaptionViewToPost(selectedImage: .TOB)
}

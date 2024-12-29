//
//  CustomMySpaceView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 25/03/24.
//

import SwiftUI

struct SinglePostView: View {
    @State var isLiked: Bool = false
    @State var isFollowed: Bool = false
    @State private var isCommentSectionActive: Bool = false
    @State var likeCount: Int = 0
    
    var post: Post  // Updated to use Post model directly
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text(post.fullName) // Display full name
                    .font(.headline)
                Spacer()
                Text("@\(post.userName)") // Display username
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 5)
            
            // Image
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .padding(.bottom, 10)
            
            // Caption
            Text(post.caption)
                .font(.body)
                .padding(.bottom, 10)
            
            // Actions
            HStack {
                Button(action: {
                    withAnimation {
                        isLiked.toggle()
                        likeCount += isLiked ? 1 : -1
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                }
                Text("\(likeCount)")
                
                Button(action: {
                    isCommentSectionActive = true
                }) {
                    Image(systemName: "message")
                }
                
                Image(systemName: "arrowshape.turn.up.right")
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .padding()
        .sheet(isPresented: $isCommentSectionActive) {
            CommentSectionView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    SinglePostView(post: Post(
        id: "1",
        userName: "sunil_sharma",
        fullName: "Sunil Sharma",
        imageUrl: "https://example.com/image.jpg",
        caption: "Exploring the mountains!"
    ))
}


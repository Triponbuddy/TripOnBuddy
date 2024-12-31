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
    @State var showMenuOptions: Bool = false
    @State private var isCommentSectionActive: Bool = false
    @State var likeCount: Int = 0
    
    var post: Post  // Directly pass a valid Post instance
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text(post.fullName) // Display full name
                    .font(.headline)
                Spacer()
                Button(action: {
                    
                }, label: {
                    if isFollowed {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                    }
                    else {
                        Button(action: {
                            isFollowed = true
                        }, label: {
                            Text("Add Buddy")
                        })
                    }
                })
            }
            .padding(.bottom, 5)
            
            // Image
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                //ProgressView()
                Image("India Gate")
                    .resizable(resizingMode: .stretch)
                
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .padding(.bottom, 10)
            
            HStack {
                Group {
                    Text(post.userName.capitalized).bold()
                    + Text(" ") + Text(post.caption ?? "")
                        
                }
                .font(.body)
                Spacer()
            }
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
        .sheet(isPresented: $showMenuOptions, content: {
            
        })
    }
}

#Preview {
    SinglePostView(post: Post(
        id: "1",
        data: [
            "userName": "sunil_sharma",
            "fullName": "Sunil Sharma",
            "mediaUrl": "https://example.com/sample.jpg",
            "caption": "Exploring the mountains!, with the friends"
        ]
    )!)
}


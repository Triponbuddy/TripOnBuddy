//
//  CommentSectionView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-26.
//

import SwiftUI

struct CommentSectionView: View {
    @State private var comments: [String] = []      // To store the list of comments
    @State private var newComment: String = ""     // To store the comment being typed
    @State private var addComment: Bool = false
    var body: some View {
        
        VStack(alignment: .leading) {
            if addComment {
                ScrollView {
                   
                    ForEach(comments, id: \.self) { comment in
                        
                        HStack {
                            Group {
                                Text("Username ")
                                    .bold()
                                +
                                Text(comment)
                            }
                            Spacer()
                        }
                        .padding(.top, 10)
                    }
                }
            }
            else {
                Spacer()
                HStack {
                    Spacer()
                    Text("Be the first to comment...")
                        .foregroundStyle(Color(.systemGray3))
                    Spacer()
                }
                
            }
            Spacer()
            HStack(alignment: .bottom, spacing: 10) {
                TextField("Enter your comment", text: $newComment, axis: .vertical)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color(.systemGray2))
                        
                    )
                    .lineLimit(0...5)
                    
                    
                // Button to add the new comment
                Button(action: {
                    // Check if the newComment is not empty
                    if !newComment.isEmpty {
                        comments.append(newComment)    // Add the new comment to the array
                        newComment = ""                // Clear the text field
                        addComment = true              // Set addComment to true (if you need it for some purpose)
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .symbolEffect(.bounce, value: addComment)
                        .frame(width: 30, height: 30)
                        .padding(4)
                        .foregroundStyle(!newComment.isEmpty ? Color(.accent) : Color(.systemGray4))
                }
                .disabled(newComment.isEmpty)  // Disable button when no text is entered
            }
            .padding(.vertical, 8)
        }
        .padding(8)
        
    }
}

#Preview {
    CommentSectionView()
}

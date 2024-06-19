//
//  AllChatsView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 11/04/24.
//

import SwiftUI
import PhotosUI

struct AllChatsView: View {
    @State var userName: String = "Sunil Sharma"
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Convos")
                                .font(.title)
                                .bold()
                            Spacer()
                            EditButton()
                                
                        }
                        
                        // Add Code for the push notifications
                        LazyVGrid(columns: [GridItem()], spacing: 10,content: {
                            ForEach(0 ..< 100) { item in
                                
                                // Add code to redirect the user to the Chats post.
                                NavigationLink(destination: {
                                    SingleChatView(userName: $userName)
                                }, label: {
                                    HStack {
                                        Image("India Gate")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .frame(width: 70, height: 70)
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text(userName)
                                                .bold()
                                            Text("message")
                                                .font(.callout)
                                        }
                                        Spacer()
                                    }
                                })
                                
                                
                                Divider()
                            }
                        })
                        
                    }
                    .padding(.horizontal)
                    
                }
            }
            .buttonStyle(SimpleButtonStyle())
            .ignoresSafeArea(edges: .bottom)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AllChatsView()
}

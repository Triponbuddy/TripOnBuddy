//
//  NotificationsView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 11/04/24.
//

import SwiftUI

struct NotificationsView: View {
    // @State private var birthDate = Date.now
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    
                    // Add Code for the push notifications
                    LazyVGrid(columns: [GridItem()], spacing: 20,content: {
                        ForEach(0 ..< 100) { item in
                            
                            // Add code to redirect the user to the notification post.
                            
                            HStack {
                                Image("India Gate")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                Group {
                                    Text("Username")
                                        .bold() +
                                    Text(" ") +
                                    Text("Notification Text is the text that will provide quick overview of the things happening around.")
                                }
                                
                                
                            }
                            Divider()
                        }
                    })
                    
                }
                .padding(.horizontal)
                
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    NotificationsView()
}

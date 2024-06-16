//
//  NotificationsView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 11/04/24.
//

import SwiftUI

struct NotificationsView: View {
    let notificationMessage = "Notification Text is the text that will provide quick overview of the things happening around."
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        
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
                                        Text(notificationMessage)
                                    }
                                    
                                }
                                Divider()
                            }
                        })
                        
                    }
                    .padding(.horizontal)
                    
                }
                .refreshable {
                    
                }
              
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Notifications")
            .navigationBarBackButtonHidden()
        }
        
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    NotificationsView()
}

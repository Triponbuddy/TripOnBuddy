//
//  ContentView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 16/03/24.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

extension Color {
    static let nileBlue = Color(red: 36/255, green: 63/255, blue: 77/255)
}

struct RootView: View {
    
    @State var selectedTab: Tabs
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    switch selectedTab {
                    case .mySpace:
                        MySpaceView()
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    Text("TripOnBuddy") // Show username
                                        .bold()
                                        .font(.title)
                                }
                                ToolbarItem(placement: .topBarTrailing) {
                                    NavigationLink(destination: {
                                        NotificationsView()
                                    }, label: {
                                        Image(systemName: "bell")
                                            .imageScale(.large)
                                            .padding(.trailing, 5)
                                        
                                    })
                                }
                                ToolbarItem(placement: .topBarTrailing) {
                                    NavigationLink(destination: {
                                        AllChatsView()
                                    }, label: {
                                        Image(systemName: "message")
                                            .imageScale(.large)
                                            .padding(.trailing, 5)
                                        
                                    })
                                }
                            }
                    case .explore:
                        ExploreView()
                    case .post:
                        PostView()
                    case .trips:
                        TripsView(switchTabs: .completed)
                    case .profile:
                        ProfileView()
                    }
                    Spacer()
                    
                    TabBarView(selectedTab: $selectedTab)
                        .ignoresSafeArea(edges: .bottom)
                        .padding([.horizontal,.bottom], 10)
                    
                    
                }
                
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    RootView(selectedTab: .mySpace)
}

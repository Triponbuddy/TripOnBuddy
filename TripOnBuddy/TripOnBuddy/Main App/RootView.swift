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
    
    @StateObject private var viewModel = RootViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    switch viewModel.selectedTab {
                    case .mySpace:
                        MySpaceView()
                            .toolbar(content: {
                                ToolbarItem(placement: .topBarLeading, content: {
                                    Text("TripOnBuddy")
                                        .font(.title)
                                        .bold()
                                })
                                viewModel.toolbarContent()
                            })
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
                    
                    TabBarView(selectedTab: $viewModel.selectedTab)
                        .ignoresSafeArea(edges: .bottom)
                        .padding([.horizontal,.bottom], 10)
                    
                    
                }
                
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    RootView()
}

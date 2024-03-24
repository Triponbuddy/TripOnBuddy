//
//  ContentView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 16/03/24.
//

import SwiftUI

struct RootView: View {
    @State var selectedTab: Tabs
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .mySpace:
                MySpaceView()
            case .explore:
                ExploreView()
            case .post:
                PostView()
            case .trips:
                TripsView()
            case .profile:
                ProfileView()
            }
            Spacer()
            
            TabBarView(selectedTab: $selectedTab)
                
            
        }
        .padding(.horizontal, 10)
        .foregroundStyle(colorScheme == .light ? Color.nileBlue : .white)
    }
}

#Preview {
    RootView(selectedTab: .mySpace)
}

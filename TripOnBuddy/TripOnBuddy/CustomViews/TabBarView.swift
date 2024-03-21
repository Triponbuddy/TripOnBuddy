//
//  TabBarView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
enum Tabs: Int {
    case mySpace = 0
    case explore = 1
    case post = 2
    case trips = 3
    case profile = 4
    
}

struct TabBarView: View {
    @Binding var selectedTab: Tabs
    @State var isActive: Bool = false
    var body: some View {
        
        HStack(alignment: .center) {
            Button(action: {
                selectedTab = .mySpace
            }, label: {
                CustomTabButton(imageName: "house", imageNameFilled: "house.fill", isActive: selectedTab == .mySpace)
            })
            Button(action: {
                selectedTab = .explore
            }, label: {
                CustomTabButton(imageName: "safari", imageNameFilled: "safari.fill", isActive: selectedTab == .explore)
            })
            Button(action: {
                selectedTab = .post
            }, label: {
                CustomTabButton(imageName: "plus.square", imageNameFilled: "plus.square.fill", isActive: selectedTab == .post)
            })
            Button(action: {
                selectedTab = .trips
            }, label: {
                CustomTabButton( imageName: "backpack", imageNameFilled: "backpack.fill", isActive: selectedTab == .trips)
            })
            Button(action: {
                
                selectedTab = .profile
                
            }, label: {
                CustomTabButton(imageName: "person.crop.circle", imageNameFilled: "person.crop.circle.fill", isActive: selectedTab == .profile)
            })
        }
        .frame(height: 82)
        .buttonStyle(SimpleButtonStyle())
    }
}

#Preview {
    TabBarView(selectedTab: .constant(.profile))
}

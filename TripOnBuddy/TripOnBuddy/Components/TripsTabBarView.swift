//
//  TripsTabBarView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 01/04/24.
//

import SwiftUI
enum TripTabs: Int {
    case completed = 0
    case upcoming = 1
}

struct TripsTabBarView: View {
    @Binding var switchTabs: TripTabs
    var body: some View {
        HStack {
            
            Button(action: {
                switchTabs = .completed
            }, label: {
                
                TripsTabBarButton(name: "Completed", isActive: switchTabs == .completed)
                
            })
            Button(action: {
                switchTabs = .upcoming
            }, label: {
                
                TripsTabBarButton(name: "Upcoming", isActive: switchTabs == .upcoming)
                
            })
        }
        .frame(height: 60)
    }
}

#Preview {
    TripsTabBarView(switchTabs: .constant(.completed))
}

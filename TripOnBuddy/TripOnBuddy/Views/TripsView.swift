//
//  TripsView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct TripsView: View {
    @State var switchTabs: TripTabs
    var body: some View {
        VStack {
            TripsTabBarView(switchTabs: $switchTabs)
            switch switchTabs {
            case .completed:
                CompletedTripsView()
            case .upcoming:
                UpcomingTripsView()
            }
            Spacer()
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    TripsView(switchTabs: .completed)
}

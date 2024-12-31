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
        ZStack {
            //BackgroundColourView()
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
            .padding([.horizontal, .top], 10)
           // .ignoresSafeArea(edges: .bottom)
            .navigationTitle("All Trips")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TripsView(switchTabs: .completed)
}

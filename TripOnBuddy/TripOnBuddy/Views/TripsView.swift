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
            HStack {
                Text("Trips View")
                    .font(.title)
                    .bold()
                Spacer()
                EditButton()
            }
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
        .navigationTitle("All Trips")
    }
}

#Preview {
    TripsView(switchTabs: .completed)
}

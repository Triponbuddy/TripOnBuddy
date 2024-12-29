//
//  CompletedTripsView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 01/04/24.
//

import SwiftUI

struct CompletedTripsView: View {
    @State var tripDetails: [TripsDetails] = []
    var dataServices = DataServices()
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                LazyVGrid(columns: [GridItem()], spacing: 10, content: {
                    ForEach(tripDetails) { item in
                        CustomTripCardView(tripDetails: TripsDetails(userName: item.userName, name: item.name, fromDate: item.fromDate, toDate: item.toDate, expectedFare: item.expectedFare, destinations: item.destinations, destinationImage: item.destinationImage), isCompleted: .constant(true))
                            .padding(.horizontal, 5)
                    }
                })
            }
            .onAppear {
               // tripDetails = dataServices.getTripsData()
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    CompletedTripsView()
}

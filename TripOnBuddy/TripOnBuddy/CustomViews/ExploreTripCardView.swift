//
//  ExploreTripCardView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 22/04/24.
//

import SwiftUI

struct ExploreTripCardView: View {
    var tripDetails: TripsDetails
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(colorScheme == .light ? Color.gray.opacity(0.5) : Color.nileBlue.opacity(0.5))
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(tripDetails.name)
                            .bold()
                            .font(.title2)
                        Text(tripDetails.userName)
                            .font(.callout)
                    }
                    Spacer()
                }
                
                Image(tripDetails.destinationImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.4)
                    .background(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 8)
                    .overlay(content: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack(alignment: .bottom) {
                                
                                Text(tripDetails.destinations.capitalized)
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            Text(tripDetails.destinationOverview ?? "")
                                .font(.callout)
                            
                        }
                        .padding(20)
                        .foregroundStyle(.white)
                        .opacity(1.0)
                    })
                
                HStack {
                    Text("From Date:".capitalized)
                    Text(tripDetails.fromDate.capitalized)
                    Spacer()
                    Button("Add Trip", action: {
                        
                    })
                    
                }
                .font(.headline)
                HStack {
                    Text("To Date:".capitalized)
                    Text(tripDetails.toDate.capitalized)
                }
                .font(.headline)
                HStack {
                    Text("Estimated Fare:".capitalized)
                    Text(tripDetails.expectedFare.capitalized)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "bookmark")
                    })
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.right")
                    })
                }
                .font(.headline)
            }
            .padding(8)
        }
        .frame(height: .infinity)
        .buttonStyle(SimpleButtonStyle())
    }
}

#Preview {
    ExploreTripCardView(tripDetails:  TripsDetails(userName: "soul_ofaDreamer", name: "Sunil Sharma", fromDate: "31-March-2024", toDate: "4-April-2024", expectedFare: "5000", destinations: "New Delhi", destinationImage: "India Gate", destinationOverview: "Delhi is a great place to visit. There are a lot of places to visit in Delhi, such as India Gate, Red Fort, Jama Masjid etc."))
}

//
//  CustomTripCardView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 31/03/24.
//

import SwiftUI

struct CustomTripCardView: View {
    @State private var currentDate: Date = .now
    var tripDetails: TripsDetails
    @Binding var isCompleted: Bool
    @Environment(\.colorScheme) var colorScheme
    @State var gender: Gender = .male
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorScheme == .light ? Color.gray.opacity(0.5) : Color.nileBlue.opacity(0.5))
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(tripDetails.destinationImage)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(tripDetails.name)
                            .bold()
                            .font(.title2)
                        Text(tripDetails.userName)
                            .font(.callout)
                    }
                    Spacer()
                    Image(systemName: "arrowshape.turn.up.right")
                    
                }
                HStack {
                    Text("Trip Destination:".capitalized)
                        .font(.title3)
                    Text(tripDetails.destinations.capitalized)
                        .font(.title3)
                }
                HStack {
                    Text("From Date:".capitalized)
                    Text(tripDetails.fromDate.capitalized)
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
                }
                .font(.headline)
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        isCompleted = true
                    }
                }, label: {
                    Text(isCompleted ? "Completed" : "Complete")
                        .padding(.horizontal, 10)
                        .background(Capsule()
                            .foregroundStyle(colorScheme == .light ? Color.nileBlue : Color.white)
                        )
                        .foregroundStyle(colorScheme == .light ? Color.white : Color.nileBlue)
                })
            }
            .buttonStyle(SimpleButtonStyle())
            .padding()
        }
        .frame(height: .infinity)
    }
}

#Preview {
    CustomTripCardView(tripDetails: TripsDetails(userName: "soul_ofaDreamer", name: "Sunil Sharma", fromDate: "31-March-2024", toDate: "4-April-2024", expectedFare: "5000", destinations: "New Delhi", destinationImage: "demo"), isCompleted: .constant(false))
}

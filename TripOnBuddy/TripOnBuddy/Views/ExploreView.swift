//
//  ExploreView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct ExploreView: View {
    @State var tripDetails: [TripsDetails] = []
    var dataServices = DataServices()
    @State var searchText = ""
    @State private var addNewTrip: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem()], content: {
                        ForEach(tripDetails) { item in
                            
                            ExploreTripCardView(tripDetails: TripsDetails(userName: item.userName, name: item.name, fromDate: item.fromDate, toDate: item.toDate, expectedFare: item.expectedFare, destinations: item.destinations, destinationImage: item.destinationImage))
                           
                        }
                    })
                    .searchable(text: $searchText, prompt: "Search...")
                    .onAppear {
                        tripDetails = dataServices.getTripsData()
                    }
                }
            }
            .navigationTitle("Explore View")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
        }
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                addNewTrip = true
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                    .padding(40)
                    .background(Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.nileBlue)
                        .opacity(0.5)
                        .padding(30)
                    )
            })
            .buttonStyle(SimpleButtonStyle())
        })
        .refreshable(action: {
            // write the code to refresh the page
        })
        .sheet(isPresented: $addNewTrip, content: {
            NavigationStack {
                CustomTextFieldView(inputText: .constant("Destination"), isTapped: .constant(true))
                CustomTextFieldView(inputText: .constant("Duration"), isTapped: .constant(true))
                NavigationLink(destination: {
                    Text("Next Page View")
                }, label: {
                    Text("Next")
                })
            }
        })
        
    }
}

#Preview {
    ExploreView()
}

//
//  TripsDetails.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 01/04/24.
//

import Foundation
struct TripsDetails: Identifiable {
    let id = UUID()
    var userName: String
    var name: String
    var fromDate: String
    var toDate: String
    var expectedFare: String
    var destinations: String
    var destinationImage: String
}

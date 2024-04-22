//
//  TripsDetails.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 01/04/24.
//

import Foundation
enum Gender: Int {
    case male, female
}
struct TripsDetails: Identifiable {
    let id = UUID()
    var userName: String
    var name: String
    var fromDate: String
    var toDate: String
    var expectedFare: String
    var destinations: String
    var destinationImage: String
    var destinationOverview: String?
    var genderSpecific: Gender?
    var totalNumOfPeople: String?
    var numberOfJoinees: String?
}

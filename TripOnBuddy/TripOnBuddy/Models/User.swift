//
//  MyProfileDetails.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var userName: String
    var fullName: String
    var userImage: String? = nil // Optional with a default value
    var bio: String? = nil // Optional with a default value
    var profession: String? = nil // Optional with a default value
    var gender: String? = nil // Optional with a default value
    var emailId: String
    var followers: [String] = [] // Default to an empty array
    var following: [String] = [] // Default to an empty array
}


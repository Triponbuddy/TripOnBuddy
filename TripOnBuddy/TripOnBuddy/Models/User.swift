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
    var userImage: String?
    var bio: String?
    var profession: String?
    var gender: String?
    var emailId: String
   
    
}

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
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
}

extension User {
    static var Mock_User = User(id: NSUUID().uuidString, userName: "Soul_Ofadreamer", fullName: "Sunil Sharma", emailId: "name@example.com")
}

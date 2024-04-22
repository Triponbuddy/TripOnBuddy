//
//  MyProfileDetails.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import Foundation

struct MyProfileDetails: Identifiable {
    let id = UUID()
    var userName: String
    var name: String
    var userImage: String?
    var bio: String?
    var profession: String?
    var gender: String?
    var emailId: String?
    //var interests: String?
//    init(name: String, userImage: String? = nil, bio: String? = nil, profession: String? = nil, gender: String? = nil, emailId: String, phoneNumber: [LoginDetails]) {
//        self.name = name
//        self.userImage = userImage
//        self.bio = bio
//        self.profession = profession
//        self.gender = gender
//        self.emailId = emailId
//        self.phoneNumber = phoneNumber
//    }
    
}

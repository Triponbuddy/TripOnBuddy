//
//  Post.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: String
    var userName: String  // Matches User model
    var fullName: String  // Matches User model
    var imageUrl: String  // URL of the uploaded image
    var caption: String   // Caption of the post
    
    // Converts Post to a Firestore-compatible dictionary
    func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "userName": userName,
            "fullName": fullName,
            "imageUrl": imageUrl,
            "caption": caption
        ]
    }
}

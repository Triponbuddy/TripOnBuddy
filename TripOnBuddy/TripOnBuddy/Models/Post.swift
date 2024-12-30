//
//  Post.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import Foundation

// Model representing a post in the app
struct Post: Identifiable, Codable {
    var id: String            // Unique identifier for the post
    var userName: String      // Username of the post creator
    var fullName: String      // Full name of the post creator
    var imageUrl: String      // URL of the image (maps to "mediaUrl" in Firestore)
    var caption: String?      // Optional caption for the post

    // Coding keys for mapping JSON fields to model properties
    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case fullName
        case imageUrl = "mediaUrl" // Map "mediaUrl" from Firestore to "imageUrl"
        case caption
    }

    // Member-wise initializer for creating a new Post
    init(id: String, userName: String, fullName: String, imageUrl: String, caption: String?) {
        self.id = id
        self.userName = userName
        self.fullName = fullName
        self.imageUrl = imageUrl
        self.caption = caption
    }

    // Custom initializer to create a Post from Firestore data
    init?(id: String, data: [String: Any]) {
        // Ensure required fields are present in the Firestore document
        guard
            let userName = data["userName"] as? String,
            let fullName = data["fullName"] as? String,
            let mediaUrl = data["mediaUrl"] as? String
        else {
            // Log error if any required field is missing
            print("Missing required fields in document: \(id)")
            return nil
        }

        self.id = id
        self.userName = userName
        self.fullName = fullName
        self.imageUrl = mediaUrl
        self.caption = data["caption"] as? String // Optional field
    }

    // Convert a Post object to a Firestore-compatible dictionary
    func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "userName": userName,
            "fullName": fullName,
            "mediaUrl": imageUrl,
            "caption": caption ?? "" // Use an empty string if caption is nil
        ]
    }
}

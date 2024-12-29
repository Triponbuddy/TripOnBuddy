//
//  Post.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

struct Post: Identifiable, Codable {
    var id: String
    var userName: String
    var fullName: String
    var imageUrl: String // Maps to mediaUrl in Firestore
    var caption: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case fullName
        case imageUrl = "mediaUrl"
        case caption
    }

    // Member-wise initializer
    init(id: String, userName: String, fullName: String, imageUrl: String, caption: String?) {
        self.id = id
        self.userName = userName
        self.fullName = fullName
        self.imageUrl = imageUrl
        self.caption = caption
    }

    // Custom initializer for decoding Firestore data
    init?(id: String, data: [String: Any]) {
        guard
            let userName = data["userName"] as? String,
            let fullName = data["fullName"] as? String,
            let mediaUrl = data["mediaUrl"] as? String
        else {
            print("Missing required fields in document: \(id)")
            return nil
        }

        self.id = id
        self.userName = userName
        self.fullName = fullName
        self.imageUrl = mediaUrl
        self.caption = data["caption"] as? String
    }

    // Convert to Firestore-compatible dictionary
    func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "userName": userName,
            "fullName": fullName,
            "mediaUrl": imageUrl,
            "caption": caption ?? ""
        ]
    }
}

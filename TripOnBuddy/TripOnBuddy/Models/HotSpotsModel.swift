//
//  HotSpotsModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 22/04/24.
//

import Foundation
struct HotSpotsModel: Identifiable, Decodable {
    let id = UUID()
    var image: String
    var personImage: String?
}

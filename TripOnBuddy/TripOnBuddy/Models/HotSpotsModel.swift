//
//  HotSpotsModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 22/04/24.
//

import Foundation
struct HotSpotsModel: Identifiable, Decodable {
    var id = UUID()
    var image: String
    var personImage: String?
    var title: String
}

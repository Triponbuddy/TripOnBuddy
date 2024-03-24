//
//  DataServices.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 24/03/24.
//

import Foundation
struct DataServices {
    func getData() -> [StoriesTabModel] {
        return [
            StoriesTabModel(name: "Sunil", image: "demo", video: ""),
            StoriesTabModel(name: "Ajay", image: "TOB", video: ""),
            StoriesTabModel(name: "Ankit", image: "TOB", video: ""),
            StoriesTabModel(name: "Sandeep", image: "demo", video: "")
        ]
    }
    func getForYouData() -> [ForYouViewModel] {
        return [
            ForYouViewModel(name: "Sunil", image: "demo", userName: "soul_ofadreamer", caption: "Went to see the sunset"),
            ForYouViewModel(name: "Ajay", image: "TOB", userName: "ajay_01", caption: " starting a new startup"),
            ForYouViewModel(name: "Sandeep", image: "demo", userName: "sandeep_02", caption: "vehle"),
            ForYouViewModel(name: "Ankit", image: "TOB", userName: "ankit_03", caption: "joining teams"),
            ForYouViewModel(name: "Ankit", image: "TOB", userName: "ankit_03", caption: "joining teams")
        ]
    }
}

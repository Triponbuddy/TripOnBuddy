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
            ForYouViewModel(name: "Sunil", image: "demo", userName: "soul_ofadreamer", caption: "Went to see the sunset on the beach. What a beautifull view."),
            ForYouViewModel(name: "Ajay", image: "TOB", userName: "ajay_01", caption: " starting a new startup"),
            ForYouViewModel(name: "Sandeep", image: "demo", userName: "sandeep_02", caption: "vehle"),
            ForYouViewModel(name: "Ankit", image: "prem mandir", userName: "ankit_03", caption: "joining teams"),
            ForYouViewModel(name: "Ankit", image: "India Gate", userName: "ankit_03", caption: "joining teams")
        ]
    }
    func getTripsData() -> [TripsDetails] {
        return [
            TripsDetails(userName: "soul_ofaDreamer", name: "Sunil Sharma", fromDate: "31-March-2024", toDate: "4-April-2024", expectedFare: "5000", destinations: "New Delhi", destinationImage: "India Gate"),
            TripsDetails(userName: "sandeep_02", name: "Sandeep Boda", fromDate: "4-April-2024", toDate: "7-April-2024", expectedFare: "4000", destinations: "Amritsar", destinationImage: "demo"),
            TripsDetails(userName: "ajay_01", name: "Ajay Bhandari", fromDate: "12-April-2024", toDate: "14-April-2024", expectedFare: "19000", destinations: "Goa", destinationImage: "demo"),
            TripsDetails(userName: "ankit_03", name: "Ankit Kumar", fromDate: "19-March-2024", toDate: "24-March-2024", expectedFare: "25000", destinations: "Vrindavan", destinationImage: "prem mandir")
        ]
    }
    func getUserData() -> [MyProfileDetails] {
        return [
            MyProfileDetails(name: "Sunil", userImage: "demo"),
            MyProfileDetails(name: "Ajay", userImage: "TOB"),
            MyProfileDetails(name: "Ankit", userImage: "prem mandir"),
            MyProfileDetails(name: "Sandeep", userImage: "demo")
        ]
    }
}

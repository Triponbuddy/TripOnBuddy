//
//  TripOnBuddyApp.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 16/03/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth



@main
struct TripOnBuddyApp: App {
    @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

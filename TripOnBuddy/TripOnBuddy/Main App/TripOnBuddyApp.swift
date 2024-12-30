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
    // Initialize the authentication view model as a shared environment object
    @StateObject private var authViewModel = AuthViewModel()
    
    init() {
        configureFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel) // Pass the auth view model to the environment
        }
    }
    
    /// Configures the Firebase SDK
    private func configureFirebase() {
        FirebaseApp.configure()
        print("Firebase successfully configured.")
    }
}

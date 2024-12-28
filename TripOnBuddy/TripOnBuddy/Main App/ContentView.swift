//
//  ContentView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                RootView(selectedTab: .mySpace)
            }
            else {
                SignInView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}

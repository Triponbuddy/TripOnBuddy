//
//  BackgroundColourView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-18.
//

import SwiftUI

struct BackgroundColourView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.nileBlue.opacity(0.5), Color.nileBlue.opacity(0.3), Color.gray.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundColourView()
}

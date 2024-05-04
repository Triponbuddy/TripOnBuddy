//
//  BackgroundView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 04/05/24.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color.gray, Color.red]),
    startPoint: .top,
    endPoint: .bottom
)

struct BackgroundView: View {
    var body: some View {
        ZStack {
            
            backgroundGradient.ignoresSafeArea()
            
        }
    }
}

#Preview {
    BackgroundView()
}

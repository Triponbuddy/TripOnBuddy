//
//  CustomTripCardView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 31/03/24.
//

import SwiftUI

struct CustomTripCardView: View {
    @State private var currentDate: Date = .now
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("demo")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("Sunil Sharma")
                            .bold()
                            .font(.title2)
                        Text("Username")
                            .font(.callout)
                    }
                    
                }
                    Text("Date: ")
                
                Text("Fare: 5000")
            }
        }
    }
}

#Preview {
    CustomTripCardView()
}

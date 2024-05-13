//
//  AddNewTripView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 13/05/24.
//

import SwiftUI

struct AddNewTripView: View {
    @State private var destination: String = ""
    @State private var duration: String = ""
    @State private var isTapped: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                //BackgroundView()
                VStack {
                    CustomTextFieldView(inputText: $destination, isTapped: $isTapped)
                    CustomTextFieldView(inputText: $duration, infoText: "Duration", isTapped: $isTapped)
                    
                    NavigationLink(destination: {
                        Text("Next Page View")
                    }, label: {
                        Text("Next")
                    })
                }
            }
        }
    }
}

#Preview {
    AddNewTripView()
}

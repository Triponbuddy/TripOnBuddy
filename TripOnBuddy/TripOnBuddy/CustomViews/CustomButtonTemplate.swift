//
//  CustomButtonTemplate.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 26/04/24.
//

import SwiftUI

struct CustomButtonTemplate: View {
    var name: String
    var width: CGFloat?
    var color: Color
    var paddingTop: CGFloat
    var body: some View {
        
        Text(name)
            .padding(15)
            .foregroundStyle(.white)
            .background(Capsule()
                .frame(width: width)
                .foregroundStyle(color)
            )
            .padding(.top, paddingTop)
    }
}

#Preview {
    CustomButtonTemplate(name: "Get OTP", width: 350, color: .gray, paddingTop: 50)
}

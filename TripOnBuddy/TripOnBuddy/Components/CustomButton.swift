//
//  CustomButton.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 22/04/24.
//

import SwiftUI

struct CustomButton: View {
    var name: String
    var image: String?
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Image(systemName: image ?? "")
                Text(name)
            }
            .frame(width: 250)
        })
        .background(RoundedRectangle(cornerRadius: 5)
            .stroke(lineWidth: 1.3)
        )
    }
}

#Preview {
    CustomButton(name: "Edit", image: "pencil")
}

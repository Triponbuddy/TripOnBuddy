//
//  CustomTextFieldView.swift
//  eRentPay
//
//  Created by Sunil Sharma on 19/12/23.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var inputText: String
    @State var infoText: String = ""
    @Binding var isTapped: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                TextField(infoText, text: $inputText) { (status) in
                    
                    // it will fire when text field is clicked
                    if status {
                        withAnimation(.easeIn(duration: 0.5)) {
                            isTapped = true
                        }
                    }
                } onCommit: {
                     // it will fire when return button is pressed...
                    withAnimation(.easeOut(duration: 0.5)) {
                        isTapped = false
                    }
                }
                .padding(.top, isTapped ? 4 : 0)
//                .background(
//                    Text(infoText)
//                        .scaleEffect(isTapped ? 0.8 : 1)
//                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
//                        .foregroundStyle(.gray)
//                    , alignment: .leading
//                )
                .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 80)
                    .fill(isTapped ? Color.nileBlue : Color.gray)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(height: 2)
                    .padding(.top, 10)
                    .padding(.horizontal, isTapped ? 2 : 8)
            }
            .padding(.top, 12)
            .background(RoundedRectangle(cornerRadius: isTapped ? 3 : 10)
                .foregroundStyle(Color.nileBlue)
                .opacity(0.2)
            )
//
        }
        .foregroundStyle(Color.nileBlue)
    }
    
}

#Preview {
    CustomTextFieldView(inputText: .constant(""), isTapped: .constant(false))
}


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
    @State var isTapped: Bool  = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                TextField("", text: $inputText) { (status) in
                    
                    // it will fire when text field is clicked
                    if status {
                        withAnimation(.easeIn) {
                            isTapped = true
                        }
                    }
                } onCommit: {
                     // it will fire when return button is pressed...
                    withAnimation(.easeOut) {
                        isTapped = false
                    }
                }
                .padding(.top, isTapped ? 15 : 0)
                .background(
                    Text(infoText)
                        .scaleEffect(isTapped ? 0.8 : 1)
                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundStyle(.gray)
                    , alignment: .leading
                )
                .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 80)
                    //.fill(isTapped && colorScheme == .light ? Color.darkEnd : Color.grayishGreen)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(height: 2)
                    .padding(.top, 10)
                    .padding(.horizontal, isTapped ? 2 : 8)
            }
            .padding(.top, 12)
            .background(RoundedRectangle(cornerRadius: isTapped ? 3 : 10)
                .foregroundStyle(.black)
                .opacity(0.2)
            )
//
        }
        
      //  .foregroundStyle(colorScheme == .dark ? Color.grayishGreen : Color.darkEnd)
    }
    
}

#Preview {
    CustomTextFieldView(inputText: .constant(""))
}


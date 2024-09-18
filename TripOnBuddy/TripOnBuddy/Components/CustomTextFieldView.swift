//
//  CustomTextFieldView.swift
//  eRentPay
//
//  Created by Sunil Sharma on 19/12/23.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var inputText: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text(title)
                    .foregroundStyle(Color.nileBlue)
                    .font(.footnote)
                    .fontWeight(.bold)
                
                TextField(placeholder, text: $inputText)
                    .foregroundStyle(Color(.systemGray))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 3)
                        .foregroundStyle(Color(.systemGray5)))
                    
                if isSecureField {
                    SecureField(placeholder, text: $inputText)
                }
            }
            .padding(.top, 12)
//
        }
        .foregroundStyle(Color.nileBlue)
    }
    
}

#Preview {
    CustomTextFieldView(inputText: .constant(""), title: "Email Id", placeholder: "name@example.com")
}


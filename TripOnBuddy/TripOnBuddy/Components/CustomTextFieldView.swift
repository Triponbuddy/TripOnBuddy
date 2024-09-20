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
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    
                if isSecureField {
                    SecureField(placeholder, text: $inputText)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.systemGray))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color(.systemGray3))
                            .frame(height: 45)
                            .shadow(color: .gray,radius: 1.5, x: 2, y: 2)
                        )
                        
                        
                }
                else {
                    TextField(placeholder, text: $inputText)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.systemGray))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color(.systemGray3))
                            .frame(height: 45)
                            .shadow(color: .gray,radius: 1.5, x: 2, y: 2)
                        )
                        
                        
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


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
      
            VStack(alignment: .leading, spacing: 16) {
                
                Text(title)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(Color.nileBlue)
                    
                if isSecureField {
                    SecureField(placeholder, text: $inputText)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.nileBlue)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(.gray.opacity(0.4))
                            .frame(height: 45)
                            .shadow(color: .gray.opacity(0.4),radius: 10, x: 2, y: 2)
                        )
                        
                        
                }
                else {
                    TextField(placeholder, text: $inputText)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.nileBlue)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(.gray.opacity(0.4))
                            .frame(height: 50)
                            .shadow(color: .gray,radius: 10, x: 2, y: 2)
                        )
                        
                        
                }
            }
            .padding(.top, 12)
//
        
        
    }
    
}

#Preview {
    CustomTextFieldView(inputText: .constant(""), title: "Email Id", placeholder: "name@example.com")
}


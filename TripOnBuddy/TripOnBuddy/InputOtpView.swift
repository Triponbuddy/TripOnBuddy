//
//  InputOtpView.swift
//  eRentPay
//
//  Created by Sunil Sharma on 14/12/23.
//

import SwiftUI
import Combine
struct InputOtpView: View {
    
    // How many fields do you want
    let numberOfFields: Int
    @State var otp: [String]
    @State private var oldValue = ""
    init(numberOfFields: Int, otp: [String], focusedField: Int? = nil) {
        self.numberOfFields = numberOfFields
        self._otp = State(initialValue: Array(repeating: "", count: numberOfFields))
    }
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var focusedField: Int?
    
    var body: some View {
        
        HStack {
            
            // number of textfields you want in your app
            ForEach(0..<numberOfFields, id: \.self) { index in
                
                TextField("", text: $otp[index], onEditingChanged: { editing in
                    
                    // change the current value with in the particular field the cursor is in...
                    if editing {
                        oldValue = otp[index]
                    }
                })
                .frame(width: 48, height: 48)
                .background(RoundedRectangle(cornerRadius: 12)
                    .frame(height: 1)
                    .padding(.top, 50)
                    .shadow(color: Color.black, radius: 20)
                )
                .multilineTextAlignment(.center)
                // if the text field is active or not
                .focused($focusedField, equals: index)
                .tag(index)
                
                .onChange(of: otp[index]) { value, newValue in
                    // limiting the text count to 1 for each text field
                    if otp[index].count > 1 {
                        
                        let currentValue = Array(otp[index])
                        
                        // if backspace pressed it will jump to previous text field
                        if currentValue[0] == Character(oldValue) {
                            otp[index] = String(otp[index].suffix(1))
                        }
                        else {
                            otp[index] = String(otp[index].prefix(1))
                        }
                    }
                    // changing the cursor focus jumping to next as soon as current is filled
                    
                    if !newValue.isEmpty {
                        if index == numberOfFields - 1 {
                            focusedField = nil
                        }
                        else {
                            focusedField = (focusedField ?? 0) + 1
                        }
                    }
                    else {
                        focusedField = (focusedField ?? 0) - 1
                    }
                    
                }
                // type of the keyboard
                .keyboardType(.numberPad)
            }
            
        }
        .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
    
}

#Preview {
    InputOtpView(numberOfFields: 6, otp: [""])
}

//
//  SignUpView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    @State var mobileNumber: String = ""
    @State private var isTapped: Bool = false
    @FocusState var isFocus: Bool
    let textLimit = 10
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Mobile Number")
            TextField("", text: $mobileNumber) { (status) in
                // change the status of the text field if this is selected or not
                if status {
                    withAnimation(.easeIn) {
                        isTapped = true
                    }
                }
            } onCommit: {
                withAnimation(.easeOut) {
                    isTapped = false
                }
            }
            .padding(.horizontal)
            .background(
                // this is the small border line below the text field
                RoundedRectangle(cornerRadius: 12)
                // change the colour and opacity of the bar below if tapped or not
                    //.foregroundStyle(isTapped ? Color.darkStart : Color.gray)
                    .opacity(isTapped ? 1.0 : 0.5)
                    .frame(height: 2)
                    .padding(.top, 40))
            // This is keyboard type
            .keyboardType(.numberPad)
            // this is to limit the number of characters in the text field
            .onReceive(Just(mobileNumber)) { _ in
                limitText(textLimit)
            }
            .keyboardType(.numberPad)
            // The focus state of the keyboard
            .focused($isFocus)
        }
            
    }
    // check the phonenumber for 10 digits or not
    func checkPhoneNumber() -> Bool {
        
        if mobileNumber.count == 10 {
            return true
        }
        return false
    }
    // function to limit the number digits for the text field
    func limitText(_ upper: Int) {
        if mobileNumber.count > upper {
            mobileNumber = String(mobileNumber.prefix(upper))
        }
    }
}

#Preview {
    SignUpView()
}

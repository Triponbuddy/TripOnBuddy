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
        ZStack {
        NavigationStack {
            
                VStack(alignment: .center) {
                    Image("TOB")
                        .resizable()
                        .frame(width: 220, height: 250)
                    HStack {
//                        Menu("+91", content: {
//                            Text("+1")
//                        })
                        Text("+91")
                        //
                        CustomTextFieldView(inputText: $mobileNumber, infoText: "Enter Mobile Numnber", isTapped: $isTapped)
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
                    if !mobileNumber.isEmpty && checkPhoneNumber() {
                        NavigationLink("Get OTP", destination:
                                        OTPScreenView()
                        )
                            .padding()
                            .foregroundStyle(.white)
                            .background(Capsule()
                                .frame(width: 200)
                            )
                            .padding(20)
                    }
                    else {
                        Text("Get OTP")
                            .padding()
                            .foregroundStyle(.white)
                            .background(Capsule()
                                .frame(width: 200)
                                .foregroundStyle(.gray)
                            )
                            .padding(40)
                    }
                }
            }
            .onTapGesture {
                // this dismisses the keyboard and deactiavtes the TextField
                withAnimation(.easeOut(duration: 0.2)) {
                    isFocus = false
                    isTapped = false
                }
            }
        }
        .padding()
        
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

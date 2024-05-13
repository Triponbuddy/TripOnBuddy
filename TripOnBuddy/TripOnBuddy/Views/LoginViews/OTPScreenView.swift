//
//  OTP_Screen.swift
//  RentPayUIDemo
//
//  Created by Sunil Sharma on 06/12/23.
//

import SwiftUI
import Combine


struct OTPScreenView: View {
    
    @State var isVerified: Bool = false
    @State var otp: [String] = [""]
    @FocusState var isFocus: Bool
    @Environment(\.colorScheme) var colorScheme
    @State private var presentSheetView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                //BackgroundView()
                VStack {
                    Image("TOB")
                        .resizable()
                        .frame(width: 200, height: 250)
                    
                    Text("Enter OTP")
                        .font(.title)
                    Spacer()
                    
                    // Input Fields for OTP
                    // Depends if you want a 4 digit OTP or a 6 Digit
                    InputOtpView(numberOfFields: 6, otp: otp)
                        .focused($isFocus)
                    
                    // Add code to make the Navigation Link work only if the OTP is filled
                    
                    Button(action: {
                        presentSheetView = true
                    }, label: {
                        CustomButtonTemplate(name: "Next", width: 350, color: .nileBlue, paddingTop: 50)
                    })
                    
                    Spacer()
                    
                }
                .padding()
                
            }
            .sheet(isPresented: $presentSheetView, content: {
                EnterUsernameView()
            })
            .blur(radius: isVerified ? 5 : 0.0)
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .onTapGesture {
                isFocus = false
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    OTPScreenView()
}

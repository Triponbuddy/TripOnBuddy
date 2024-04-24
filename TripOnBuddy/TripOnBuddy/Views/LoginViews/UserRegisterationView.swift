//
//  UserRegisterationView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 24/04/24.
//

import SwiftUI

struct UserRegisterationView: View {
    @State private var username: String = ""
    @State var isTapped: Bool = false
    @FocusState var isFocus: Bool
    var body: some View {
        ZStack {
            VStack {
                CustomTextFieldView(inputText: $username, infoText: "Your buddy name...", isTapped: $isTapped)
                    .autocapitalization(.none)
                    .focused($isFocus)
                Button("Validate") {
                    if validateUserName(username) {
                        print("Username is valid.")
                    } else {
                        print("Invalid username. Only alphabets, numbers, '-', '_', and '.' are allowed.")
                    }
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
    func validateUserName(_ userName: String) -> Bool {
        let regex = "^[A-Za-z0-9._-]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: username)
    }
}

#Preview {
    UserRegisterationView()
}

//
//  EnterFullNameView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 26/04/24.
//

import SwiftUI

struct EnterFullNameView: View {
    @State var username: String = ""
    @State var isTapped: Bool = false
    @FocusState var isFocus: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextFieldView(inputText: $username, infoText: "Your buddy name...*", isTapped: $isTapped)
                    .autocapitalization(.none)
                    .focused($isFocus)
                if !username.isEmpty {
                    NavigationLink(destination: {
                        Text("Next Page")
                    }, label: {
                        CustomButtonTemplate(name: "Next", width: 350, color: .nileBlue, paddingTop: 50)
                    })
                }
                else {
                    CustomButtonTemplate(name: "Next", width: 350, color: .gray, paddingTop: 50)
                }
                Spacer()
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                })
            })
        }
        .navigationBarBackButtonHidden(true)
        
        
        
    }
    func validateUserName(_ userName: String) -> Bool {
        let regex = "^[A-Za-z0-9._-]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: username)
    }
}

#Preview {
    EnterFullNameView()
}

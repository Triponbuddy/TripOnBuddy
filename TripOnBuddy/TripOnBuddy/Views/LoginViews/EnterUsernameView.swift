//
//  UserRegisterationView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 24/04/24.
//

import SwiftUI

struct EnterUsernameView: View {
    @State private var username: String = ""
    @State var isTapped: Bool = false
    @FocusState var isFocus: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 15) {
                    CustomTextFieldView(inputText: $username, infoText: "Your buddy name...*", isTapped: $isTapped)
                        .autocapitalization(.none)
                        .focused($isFocus)
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("To create your Buddy Name use:")
                            Text("""
                         •  A-Z or a-z
                         •  0-9
                         •  _ - .
                         """)
                        }
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(.gray)
                        
                        Spacer()
                    }
                    if !username.isEmpty {
                        NavigationLink(destination: {
                            EnterFullNameView()
                        }, label: {
                            CustomButtonTemplate(name: "Next", width: 350, color: .nileBlue, paddingTop: 50)
                        })
                    }
                    else {
                        CustomButtonTemplate(name: "Next", width: 350, color: .gray, paddingTop: 50)
                    }
                    //                Button("Validate") {
                    //                    if validateUserName(username) {
                    //                        print("Username is valid.")
                    //                    } else {
                    //                        print("Invalid username. Only alphabets, numbers, '-', '_', and '.' are allowed.")
                    //                    }
                    //                }
                }
            }
            .onTapGesture {
                // this dismisses the keyboard and deactiavtes the TextField
                withAnimation(.easeOut(duration: 0.2)) {
                    isFocus = false
                    isTapped = false
                }
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
        .navigationBarBackButtonHidden()
        
        
    }
    
    func validateUserName(_ userName: String) -> Bool {
        let regex = "^[A-Za-z0-9._-]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: username)
    }
}

#Preview {
    EnterUsernameView()
}

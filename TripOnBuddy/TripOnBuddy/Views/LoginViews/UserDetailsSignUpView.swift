//
//  EnterFullNameView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 26/04/24.
//

import SwiftUI

struct UserDetailsSignUpView: View {
    @State var username: String = ""
    @State var isTapped: Bool = false
    @FocusState var isFocus: Bool
    @Environment(\.dismiss) var dismiss
    @State private var birthDate = Date.now
    @State var gender: Gender = .male
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                VStack {
                    Text("Enter Your Details")
                        .font(.title)
                        .bold()
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text("Enter Your Full Name")
                    CustomTextFieldView(inputText: $username, infoText: "Your Full Name...*", isTapped: $isTapped)
                        .autocapitalization(.none)
                        .focused($isFocus)
                }
                DatePicker("Date Of Birth*", selection: $birthDate, displayedComponents: .date)
                    .padding(.vertical, 10)
                    .datePickerStyle(.compact)
                HStack {
                    Text("Gender*")
                    Spacer()
                    Button(action: {
                        gender = .male
                    }, label: {
                        Text("Male")
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                    })
                    .background(Capsule()
                        .foregroundStyle(gender == .male ? .blue : .gray))
                    Button(action: {
                        gender = .female
                    }, label: {
                        Text("Female")
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                    })
                    .background(Capsule()
                        .foregroundStyle(gender == .female ? .pink : .gray))
                }
                
                
                if !username.isEmpty {
                    NavigationLink(destination: {
                        EnterEmailView()
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
    UserDetailsSignUpView()
}

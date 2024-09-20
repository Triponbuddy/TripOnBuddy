//
//  SignInView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-18.
//

import SwiftUI

struct SignInView: View {
    @State var emailId: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewmodel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundColourView()
                VStack(alignment: .center) {
                    
                    Image("TOB")
                        .resizable()
                        .frame(width: 220, height: 250)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextFieldView(
                            inputText: $emailId,
                            title: "Email Id",
                            placeholder: "name@example.com",
                            isSecureField: false)
                        
                        CustomTextFieldView(
                            inputText: $password,
                            title: "Password",
                            placeholder: "password",
                            isSecureField: true)
                    }
                    .padding(.top)
                    
                    Button(action: {
                        Task {
                            try await viewmodel.signIN(withEmail: emailId, password: password)
                        }
                    }, label: {
                        Text("Sign In")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    })
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        SignUpView()
                            .navigationBarBackButtonHidden()
                    }, label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account? ")
                            Text("Sign Up")
                                .fontWeight(.bold)
                            
                        }
                        .font(.system(size: 14))
                        
                    })
                    
                }
                .padding(.horizontal, 8)
            }
        }
    }
}

extension SignInView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !emailId.isEmpty
        && emailId.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    SignInView()
}

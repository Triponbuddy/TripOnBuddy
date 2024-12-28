//
//  SignUpView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var fullName: String = ""
    @State private var userName: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewmodel: AuthViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                
                
                
                VStack(alignment: .center) {
                    Image("TOB")
                        .resizable()
                        .frame(width: 150, height: 150)
                    VStack(alignment: .leading, spacing: 10) {
                        
                        CustomTextFieldView(inputText: $fullName, title: "Full Name", placeholder: "full name", isSecureField: false)
                        
                        CustomTextFieldView(inputText: $userName, title: "User Name", placeholder: "username", isSecureField: false)
                        
                        CustomTextFieldView(inputText: $emailID, title: "Email Id", placeholder: "name@example.com", isSecureField: false)
                        
                        CustomTextFieldView(inputText: $password, title: "Password", placeholder: "password", isSecureField: true)
                        
                        CustomTextFieldView(inputText: $confirmPassword, title: "Confirm Password", placeholder: "confirm password", isSecureField: true)
                    }
                    
                    Button(action: {
                        Task {
                            try await viewmodel.createUser(withEmail: emailID, password: password, fullName: fullName, username: userName)
                        }
                    }, label: {
                        Text("Sign Up")
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
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack(spacing: 3) {
                            Text("Already have an account?")
                            Text("Sign In")
                                .fontWeight(.bold)
                        }
                        
                    })
                    
                }
                .padding(.horizontal, 8)
                
            }
            
        }
        
    }
}
extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !emailID.isEmpty
        && emailID.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
        && !userName.isEmpty
        && userName.contains(".") || userName.contains("_")
    }
}
#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}

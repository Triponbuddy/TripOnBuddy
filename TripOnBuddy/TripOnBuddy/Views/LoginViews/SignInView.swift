//
//  SignInView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-18.
//

import SwiftUI

// SignInView: A screen for users to sign in to their account
struct SignInView: View {
    @State var emailId: String = ""       // State variable to store user's email input
    @State var password: String = ""     // State variable to store user's password input
    @EnvironmentObject var viewmodel: AuthViewModel // Access the authentication view model

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    
                    // App Logo
                    Image("TOB")
                        .resizable()
                        .frame(width: 220, height: 250)
                    
                    // Input fields for email and password
                    VStack(alignment: .leading, spacing: 4) {
                        // Email input field
                        CustomTextFieldView(
                            inputText: $emailId,
                            title: "Email Id",
                            placeholder: "name@example.com",
                            isSecureField: false
                        )
                        
                        // Password input field
                        CustomTextFieldView(
                            inputText: $password,
                            title: "Password",
                            placeholder: "password",
                            isSecureField: true
                        )
                    }
                    .padding(.top)
                    
                    // Sign-In Button
                    Button(action: {
                        // Trigger sign-in action using the AuthViewModel
                        Task {
                            try await viewmodel.signIN(withEmail: emailId, password: password)
                        }
                    }, label: {
                        Text("Sign In")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    })
                    .background(Color(.systemBlue)) // Blue background for the button
                    .disabled(!formIsValid) // Disable button if form is invalid
                    .opacity(formIsValid ? 1.0 : 0.5) // Adjust opacity based on form validity
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Spacer() // Push the content to the top
                    
                    // Navigation link to the Sign-Up screen
                    NavigationLink(destination: {
                        SignUpView()
                            .navigationBarBackButtonHidden() // Hide the back button on the Sign-Up screen
                    }, label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account? ")
                            Text("Sign Up")
                                .fontWeight(.bold) // Highlight the "Sign Up" text
                        }
                        .font(.system(size: 14))
                    })
                }
                .padding(.horizontal, 8) // Add padding to the horizontal edges
            }
        }
    }
}

// Extension to validate the Sign-In form
extension SignInView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // The form is valid if:
        // - Email is not empty and contains "@"
        // - Password is not empty and is at least 6 characters long
        return !emailId.isEmpty
            && emailId.contains("@")
            && !password.isEmpty
            && password.count > 5
    }
}

// Preview for SwiftUI design canvas
#Preview {
    SignInView()
        .environmentObject(AuthViewModel()) // Provide the AuthViewModel for testing
}

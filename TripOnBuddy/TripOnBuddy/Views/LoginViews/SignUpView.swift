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
import PhotosUI

// A custom ImagePicker component to allow users to select an image from their gallery
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage? // Binds the selected image to the parent view
    
    // Coordinator class to handle image picker delegate methods
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        // Called when an image is selected from the picker
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage { // Get the original image
                parent.image = image
            }
            picker.dismiss(animated: true) // Dismiss the picker
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self) // Create a coordinator instance
    }
    
    // Create and configure the UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // Set the coordinator as delegate
        picker.allowsEditing = true // Allow editing of the image
        return picker
    }
    
    // No update needed for the UIImagePickerController
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct SignUpView: View {
    
    // State variables to store form inputs and manage UI states
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var fullName: String = ""
    @State private var userName: String = ""
    @State private var isCheckingUsername: Bool = false // Indicates if username is being checked
    @State private var isUsernameTaken: Bool = false // Indicates if the username is already taken
    @State private var profileImage: UIImage? // Holds the selected profile image
    @State var showImagePicker: Bool = false // Toggles the image picker sheet
    @StateObject private var imagePickerViewModel = PhotoPickerViewModel() // ViewModel for handling photo picker
    @Environment(\.dismiss) var dismiss // Dismiss the view when called
    @EnvironmentObject var viewmodel: AuthViewModel // Access the authentication ViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    // App logo
                    Image("TOB")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    // Profile Image Selector
                    Button(action: {
                        // Open image picker when tapped
                        showImagePicker.toggle()
                    }) {
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle()) // Display image as a circle
                        } else {
                            Text("Select a Profile Photo") // Placeholder text
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $profileImage) // Show image picker sheet
                    }
                    
                    // Form fields for user details
                    VStack(alignment: .leading, spacing: 10) {
                        // Full Name input
                        CustomTextFieldView(inputText: $fullName, title: "Full Name", placeholder: "full name", isSecureField: false)
                        
                        // Username input with real-time availability check
                        CustomTextFieldView(inputText: $userName, title: "User Name", placeholder: "username", isSecureField: false)
                            .onChange(of: userName) { _ in
                                checkUsernameAvailability() // Check if the username is available
                            }
                        if isCheckingUsername {
                            Text("Checking username availability...")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else if isUsernameTaken {
                            Text("Username is already taken.")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        // Email input
                        CustomTextFieldView(inputText: $emailID, title: "Email Id", placeholder: "name@example.com", isSecureField: false)
                        
                        // Password input
                        CustomTextFieldView(inputText: $password, title: "Password", placeholder: "password", isSecureField: true)
                        
                        // Confirm Password input
                        CustomTextFieldView(inputText: $confirmPassword, title: "Confirm Password", placeholder: "confirm password", isSecureField: true)
                    }
                    
                    // Sign-Up Button
                    Button(action: {
                        Task {
                            try await viewmodel.createUser(
                                withEmail: emailID,
                                password: password,
                                fullName: fullName,
                                username: userName,
                                image: profileImage
                            ) // Create a new user
                        }
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    })
                    .background(Color(.systemBlue)) // Button background color
                    .disabled(!formIsValid) // Disable if form is invalid
                    .opacity(formIsValid ? 1.0 : 0.5) // Adjust opacity based on form validity
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    // Navigate to Sign-In screen
                    Button(action: {
                        dismiss() // Dismiss current view
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
    
    // Check if the username is already taken
    private func checkUsernameAvailability() {
        guard !userName.isEmpty else { // Skip if username is empty
            isUsernameTaken = false
            return
        }
        isCheckingUsername = true // Start checking
        isUsernameTaken = false
        
        viewmodel.checkIfUsernameExists(userName) { exists in
            DispatchQueue.main.async {
                self.isCheckingUsername = false // Stop checking
                self.isUsernameTaken = exists // Update state
            }
        }
    }
}

// Protocol to validate the form fields
extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !emailID.isEmpty // Email must not be empty
        && emailID.contains("@") // Email must contain @
        && !password.isEmpty // Password must not be empty
        && password.count > 5 // Password must be at least 6 characters
        && confirmPassword == password // Confirm password must match
        && !fullName.isEmpty // Full name must not be empty
        && !userName.isEmpty // Username must not be empty
        && (userName.contains(".") || userName.contains("_")) // Username must contain a dot or underscore
    }
}

// Preview for SwiftUI canvas
#Preview {
    SignUpView()
        .environmentObject(AuthViewModel()) // Provide the AuthViewModel to the view
}

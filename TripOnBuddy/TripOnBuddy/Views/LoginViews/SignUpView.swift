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


import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}



struct SignUpView: View {
    
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var fullName: String = ""
    @State private var userName: String = ""
    @State private var profileImage: UIImage?
    @State var showImagePicker: Bool = false
    @StateObject private var imagePickerViewModel = PhotoPickerViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewmodel: AuthViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack(alignment: .center) {
                    Image("TOB")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    // Profile Image Selector
                    Button(action: {
                        // Open image picker
                        showImagePicker.toggle()
                    }) {
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            Text("Select a Profile Photo")
                                .alignmentGuide(.leading) { g in g[HorizontalAlignment.leading]
                                    
                                }
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        
                        CustomTextFieldView(inputText: $fullName, title: "Full Name", placeholder: "full name", isSecureField: false)
                        
                        CustomTextFieldView(inputText: $userName, title: "User Name", placeholder: "username", isSecureField: false)
                        
                        CustomTextFieldView(inputText: $emailID, title: "Email Id", placeholder: "name@example.com", isSecureField: false)
                        
                        CustomTextFieldView(inputText: $password, title: "Password", placeholder: "password", isSecureField: true)
                        
                        CustomTextFieldView(inputText: $confirmPassword, title: "Confirm Password", placeholder: "confirm password", isSecureField: true)
                    }
                    
                    Button(action: {
                        Task {
                            try await viewmodel.createUser(withEmail: emailID, password: password, fullName: fullName, username: userName, image: profileImage)
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
        && (userName.contains(".") || userName.contains("_"))
        
    }
}
#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}

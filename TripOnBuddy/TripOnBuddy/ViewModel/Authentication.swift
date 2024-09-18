//
//  Authentication.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-09-17.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIN(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            await fetchUser()
            
        } catch {
            print("DEBUG: Failed to Sign In the user with error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = MyProfileDetails(id: result.user.uid, userName: username, fullName: fullName, emailId: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            
            print("DEBUG: Failed to Create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil  // takes back to login screen wipes us out
            self.currentUser = nil  // no current user is active in the app
        }
        catch {
            print("DEBUG: Failed to Sign Out the user with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        print("Deleted account Successfully.")
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        
        // self.currentUser = try? snapshot.data(as: MyProfileDetails.self)
        
        print("DEBUG: Current User is \(self.currentUser)")
    }
}

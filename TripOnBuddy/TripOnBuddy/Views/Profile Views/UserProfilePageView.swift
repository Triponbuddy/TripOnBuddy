//
//  UserProfilePageView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 21/04/24.
//

import SwiftUI

struct UserProfilePageView: View {
    var userProfileDetails: User
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 10) {
                if let user = viewModel.currentUser {
                    VStack {
                        
                        Text(user.userName)
                        Text(user.fullName)
                        Text(user.bio ?? "")
                    }
                    .font(.headline)
                }
                
                
            }
        }
    }
}

#Preview {
    UserProfilePageView(userProfileDetails:  User(id: "", userName: "Soul_ofadreamer", fullName: "Sunil Sharma", userImage: "demo", bio: "Radhe Radhe", emailId: ""))
}

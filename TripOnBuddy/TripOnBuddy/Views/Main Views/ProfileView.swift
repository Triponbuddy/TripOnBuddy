//
//  ProfileView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                
                //if let user = viewModel.currentUser {
                VStack(alignment: .leading, spacing: 4) {
                    
                    // Text(user.userName)
                    // Text(user.fullName)
                    //  Text(user.bio ?? "")
                    Text("Username") // fetch user name
                    Text("Full Name")// fetch full name
                    Text("Userbio")
                }
                .font(.headline)
                // }
                
                Button("Sign Out", action: {
                    viewModel.signOut()
                })
                
                
                //Spacer()
            }
            .padding([.horizontal, .top], 10)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Profile View")
                        .font(.title)
                        .bold()
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            }
        }
        
    }
}

#Preview {
    ProfileView()
}

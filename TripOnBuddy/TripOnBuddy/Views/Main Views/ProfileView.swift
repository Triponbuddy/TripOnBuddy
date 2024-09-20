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
        VStack(alignment: .leading) {
            HStack {
                Text("Profile View")
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
            
            VStack(alignment: .leading, spacing: 10) {
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
                
            }
        }
        .padding([.horizontal, .top], 10)
       
    }
}

#Preview {
    ProfileView()
}

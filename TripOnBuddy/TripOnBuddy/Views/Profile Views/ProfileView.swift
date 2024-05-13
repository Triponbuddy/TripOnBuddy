//
//  ProfileView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct ProfileView: View {
    @State var userProfileDetails: [MyProfileDetails] = []
    var dataServices = DataServices()
    var body: some View {
        VStack {
            HStack {
                Text("Profile View")
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
            UserProfilePageView(userProfileDetails: MyProfileDetails(userName: "soul_ofaDreamer".capitalized, name: "Sunil", userImage: "demo", bio: "Radhe Radhe"))
        }
        .onAppear(perform: {
            userProfileDetails = dataServices.getUserData()
        })
        Spacer()
        HStack {
            
        }
    }
}

#Preview {
    ProfileView()
}

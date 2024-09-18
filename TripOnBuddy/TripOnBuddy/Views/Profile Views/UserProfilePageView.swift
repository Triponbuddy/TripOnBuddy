//
//  UserProfilePageView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 21/04/24.
//

import SwiftUI

struct UserProfilePageView: View {
    var userProfileDetails: MyProfileDetails
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Image(userProfileDetails.userImage ?? "")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Spacer()
                VStack {
                    // tracking follower count
                    Text("0")
                    Text("Buddies")
                }
                Spacer()
            }
            VStack(alignment: .leading) {
                Text(userProfileDetails.userName)
                    
                Text(userProfileDetails.fullName)
            }
            .font(.title3)
                .bold()
            Text(userProfileDetails.bio ?? "")
                .font(.subheadline)
                .lineLimit(4)
            Text(userProfileDetails.profession ?? "iOS Developer")
                .font(.subheadline)
            HStack {
                Spacer()
                CustomButton(name: "Edit", image: "pencil")
                Spacer()
                
            }
            .buttonStyle(SimpleButtonStyle())
            
            Divider()
        }
    }
}

#Preview {
    UserProfilePageView(userProfileDetails:  MyProfileDetails(id: "", userName: "Soul_ofadreamer", fullName: "Sunil Sharma", userImage: "demo", bio: "Radhe Radhe"))
}

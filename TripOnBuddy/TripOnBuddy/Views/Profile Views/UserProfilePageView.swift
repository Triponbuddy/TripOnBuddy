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
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Image(userProfileDetails.userImage ?? "")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(userProfileDetails.userName)
                        .font(.title3)
                        .bold()
                    Text(userProfileDetails.name)
                        .font(.headline)
                }
                Spacer()
            }
            
            Text(userProfileDetails.bio ?? "")
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
    UserProfilePageView(userProfileDetails:  MyProfileDetails(userName: "Soul_ofadreamer", name: "Sunil Sharma", userImage: "demo", bio: "Radhe Radhe"))
}

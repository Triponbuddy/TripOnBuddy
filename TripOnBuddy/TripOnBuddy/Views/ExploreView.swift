//
//  ExploreView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI

struct ExploreView: View {
    @State var userProfileView: [MyProfileDetails] = []
    var dataServices = DataServices()
    @State var searchText = ""
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: [GridItem()], content: {
                ForEach(userProfileView) { item in
                    HStack {
                        Image(item.userImage ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text(item.name)
                        Spacer()
                            
                    }
                    
                }
            })
            .searchable(text: $searchText, prompt: "Search...")
            .onAppear {
                userProfileView = dataServices.getUserData()
            }
        }
    }
}

#Preview {
    ExploreView()
}

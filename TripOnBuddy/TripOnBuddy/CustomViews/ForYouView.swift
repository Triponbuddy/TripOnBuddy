//
//  CustomMySpaceView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 25/03/24.
//

import SwiftUI

struct ForYouView: View {
    @State var isLiked: Bool = false
    var mySpaceViewModel: ForYouViewModel
    @State var isFollowed: Bool = false
    var body: some View {
        
        ZStack {
            
            VStack {
                HStack {
                    Text(mySpaceViewModel.name)
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isFollowed = true
                        }
                    }) {
                        if isFollowed {
                            Menu(content: {
                                Button("Following", action: {
                                    isFollowed = false
                                })
                                NavigationLink(destination: Text("User Profile View"), label: {
                                    Text("View Profile")
                                })
                            }, label: {
                                Image(systemName: "ellipsis")
                                    .rotationEffect(Angle(degrees: 90))
                            })
                        }
                        else {
                            Text("Follow")
                        }
                    }
                }
                .font(.title3)
                .bold()
                Spacer()
                Image(mySpaceViewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                Spacer()
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isLiked.toggle()
                        }
                    }, label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .symbolEffect(.bounce, value: isLiked)
                            .foregroundStyle(isLiked ? .red : Color.nileBlue)
                    })
                    
                    Image(systemName: "message")
                    Image(systemName: "arrowshape.turn.up.right")
                    Spacer()
                    Text("Add Trip")
                }
                .padding(.vertical, 10)
                HStack(alignment: .firstTextBaseline) {
                    Text(mySpaceViewModel.userName.capitalized)
                        .bold()
                    Text(mySpaceViewModel.caption!)
                    Spacer()
                }
                .padding(.bottom, 10)
            }
        }
    }
}

#Preview {
    ForYouView(mySpaceViewModel: ForYouViewModel(name: "Ankit", image: "TOB", userName: "ankit_03", caption: "joining teams"))
}

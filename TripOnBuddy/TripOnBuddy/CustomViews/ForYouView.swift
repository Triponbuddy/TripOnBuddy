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
    @State private var isCommentSectionActive: Bool = false
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
                                Button("Remove Buddy", action: {
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
                            Text("Join")
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
                    Button(action: {
                        isCommentSectionActive = true
                    }, label: {
                        Image(systemName: "message")
                    })
                   
                    Image(systemName: "arrowshape.turn.up.right")
                    Spacer()
                    Text("Add Trip")
                }
                .padding(.vertical, 10)
                VStack (alignment: .leading, spacing: 0) {
                    Group {
                         Text(mySpaceViewModel.userName.capitalized)
                             .bold()
                             + Text(" ")
                        + Text(mySpaceViewModel.caption!)
                     }
                     .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
               
            }
            .sheet(isPresented: $isCommentSectionActive, content: {
                Text("Add Comments Here")
            })
        }
        .buttonStyle(SimpleButtonStyle())
    }
}

#Preview {
    ForYouView(mySpaceViewModel: ForYouViewModel(name: "Ankit", image: "TOB", userName: "ankit_03", caption: "joining teams"))
}

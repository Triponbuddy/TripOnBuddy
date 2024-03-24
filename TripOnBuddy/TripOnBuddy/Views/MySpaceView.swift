//
//  MySpaceView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI

struct MySpaceView: View {
    
    @State var yourStories: [StoriesTabModel] = []
    var dataServices = DataServices()
    @State var forYouData: [ForYouViewModel] = []
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("TripOnBuddy")
                        .bold()
                        .font(.title)
                    
                    Spacer()
                    Image(systemName: "bell")
                        .imageScale(.large)
                        .padding(.trailing, 5)
                    Image(systemName: "message")
                        .imageScale(.large)
                    
                }
                
                
                ScrollView {
                    //
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(yourStories) { item in
                                StoryView(stories: StoriesTabModel(name: item.name, image: item.image, video: item.video))
                            }
                        })
                    }
                    .scrollIndicators(.hidden)
                    HStack {
                        Text("Hotspots")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()],spacing: 10, content: {
                            ForEach(0..<14) { item in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 300, height: 200)
                                        .foregroundStyle(.blue)
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            HStack {
                                                Image(systemName: "person.crop.circle.badge.plus.fill")
                                                    .padding(.bottom, 15)
                                                Image(systemName: "person.crop.circle.badge.plus.fill")
                                                    .padding(.bottom, 15)
                                                    .opacity(0.7)
                                                Image(systemName: "person.crop.circle.badge.plus.fill")
                                                    .padding(.bottom, 15)
                                                    .opacity(0.5)
                                                
                                            }
                                            .padding(.trailing)
                                        }
                                    }
                                }
                                
                            }
                        })
                    }
                    .scrollIndicators(.hidden)
                    HStack {
                        Text("For You")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    LazyVGrid(columns: [GridItem()], spacing: 10, content: {
                        ForEach(forYouData) { item in
                            ForYouView(mySpaceViewModel: ForYouViewModel(name: item.name, image: item.image, userName: item.userName, caption: item.caption))
                        }
                    })
                }
                .scrollIndicators(.hidden)
            }
            .padding([.horizontal, .top], 10)
            //.background(Color.offWhite)
            .monospaced()
            .foregroundStyle(Color.nileBlue)
            .onAppear {
                yourStories = dataServices.getData()
                forYouData = dataServices.getForYouData()
            }
        }
    }
}

#Preview {
    MySpaceView()
}

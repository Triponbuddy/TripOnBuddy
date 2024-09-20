//
//  MySpaceView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
import PhotosUI

struct MySpaceView: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    @State var yourStories: [StoriesTabModel] = []
    var dataServices = DataServices()
    @State var forYouData: [ForYouViewModel] = []
    @State var isTapped: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var profileDetails: User = User(id: "", userName: "", fullName: "Sunil Sharma", emailId: "")
    var body: some View {
        NavigationStack {
            ZStack {
                //BackgroundColourView()
                VStack {
                    HStack {
                        Text("TripOnBuddy") // Show username
                            .bold()
                            .font(.title)
                        
                        Spacer()
                        NavigationLink(destination: {
                            NotificationsView()
                        }, label: {
                            Image(systemName: "bell")
                                .imageScale(.large)
                                .padding(.trailing, 5)
                            
                        })
                        
                        NavigationLink(destination: {
                            AllChatsView()
                        }, label: {
                            Image(systemName: "message")
                                .imageScale(.large)
                            
                        })
                        
                    }
                    ScrollView {
                        //
                        ScrollView(.horizontal) {
                            HStack {
                                PhotosPicker(selection: $viewModel.imageSelection, matching: .any(of: [.images, .videos, .slomoVideos, .cinematicVideos, .depthEffectPhotos, .panoramas, .timelapseVideos]),label: {
                                    
                                    if let image = viewModel.selecetedImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 100)
                                            .clipShape(Circle())
                                        
                                    }
                                    else {
                                        ZStack {
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "plus")
                                                        .frame(width: 30, height: 30)
                                                        .foregroundStyle(.white)
                                                        .background(.gray)
                                                        .clipShape(Circle())
                                                })
                                            
                                        }
                                        
                                    }
                                })
                                .foregroundStyle(Color.nileBlue)
                                LazyHGrid(rows: [GridItem()], spacing: 20, content: {
                                    ForEach(yourStories) { item in
                                        
                                        StoryView(stories: StoriesTabModel(name: item.name, image: item.image, video: item.video))
                                        
                                    }
                                })
                            }
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
                .onAppear {
                    yourStories = dataServices.getData()
                    forYouData = dataServices.getForYouData()
                }
            }.buttonStyle(SimpleButtonStyle())
                .refreshable {
                    // put code here to sync the Feed
                }
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MySpaceView()
}

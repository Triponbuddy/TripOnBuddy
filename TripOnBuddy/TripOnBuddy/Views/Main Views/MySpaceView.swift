//
//  MySpaceView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
import PhotosUI
import Firebase

struct MySpaceView: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    @State var yourStories: [StoriesTabModel] = []
    @State private var posts: [Post] = []
    @State var isTapped: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    ScrollView {
                        //
                        ScrollView(.horizontal) {
                            HStack {
                                PhotosPicker(selection: $viewModel.imageSelection, matching: .any(of: [.images, .videos, .slomoVideos, .cinematicVideos, .depthEffectPhotos, .panoramas, .timelapseVideos]),label: {
                                    
                                    if let image = viewModel.selectedImage {
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
                                            .frame(width: 360, height: 200)
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
                            
                        })
                    }
                    .scrollIndicators(.hidden)
                }
                .padding([.horizontal, .top], 10)
                .onAppear {
                    //
                    fetchPosts()
                }
                
            }.buttonStyle(SimpleButtonStyle())
                .refreshable {
                    // put code here to sync the Feed
                }
            
        }
        .navigationBarBackButtonHidden()
    }
    
    func fetchPosts() {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            posts = documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
        }
    }
}

#Preview {
    MySpaceView()
}

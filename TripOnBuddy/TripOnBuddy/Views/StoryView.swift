//
//  StoryView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 24/03/24.
//

import SwiftUI

struct StoryView: View {
    @State private var name: String = ""
    var dataServices = DataServices()
    var stories: StoriesTabModel
    @State private var isViewed: Bool = false
    @State private var isDown = false
    var body: some View {
        
        VStack {
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 2)
                    .frame(width: 90)
                    .foregroundStyle(isViewed ? .gray : .red)
                Image(stories.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        isViewed = true
                    }
            }
            
            Text(stories.name)
                .bold()
            
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isViewed, content: {
            CustomStoryView(stories: StoriesTabModel(name: stories.name, image: stories.image, video: stories.video))
            
        })
        .presentationCornerRadius(20)
        
    }
}

#Preview {
    StoryView(stories: StoriesTabModel(name: "Sunil", image: "demo", video: ""))
}

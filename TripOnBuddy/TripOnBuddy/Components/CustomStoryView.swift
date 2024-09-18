//
//  CustomStoryView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 25/03/24.
//

import SwiftUI

struct CustomStoryView: View {
    var stories: StoriesTabModel
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(stories.name)
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding([.horizontal, .top ], 10)
                Spacer()
            }
            .background(
                Image(stories.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
         
            
        }
        .foregroundStyle(.white)
        
        
    }
}

#Preview {
    CustomStoryView(stories: StoriesTabModel(name: "Sunil", image: "demo", video: ""))
}

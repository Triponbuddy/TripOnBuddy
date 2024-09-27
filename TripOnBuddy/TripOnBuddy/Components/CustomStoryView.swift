//
//  CustomStoryView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 25/03/24.
//

import SwiftUI

struct CustomStoryView: View {
    var stories: StoriesTabModel
    @State var storyCount: Int = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(stories.name)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .padding(.horizontal, 8)
                            .padding(.top, 2)
                            
                    })
                    .buttonStyle(SimpleButtonStyle())
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
         Spacer()
            
                
            
        }
        .foregroundStyle(.white)
        
        
    }
}

#Preview {
    CustomStoryView(stories: StoriesTabModel(name: "Sunil", image: "demo", video: ""))
}

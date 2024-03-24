//
//  CustomTTabButton.swift
//  CustomTabBar
//
//  Created by Sunil Sharma on 01/10/23.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}
extension Color {
    static let nileBlue = Color(red: 36/255, green: 63/255, blue: 77/255)
}

struct CustomTabButton: View {
    var imageName: String
    var imageNameFilled: String
    var isActive: Bool
    @Namespace private var animationNameSpace
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                
                VStack(spacing: 4){
                    
                    Image(systemName: isActive ? imageNameFilled : imageName)
                        .resizable()
                        .symbolEffect(.scale.up, options: .nonRepeating, isActive: isActive)
                        .frame(width: 25, height: 25)
                        .foregroundColor(colorScheme == .light ? Color.nileBlue : .white)
                        .animation(.bouncy, value: isActive)
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        
    }
}

#Preview {
    CustomTabButton(imageName: "plus.square", imageNameFilled: "plus.square.fill", isActive: true)
}

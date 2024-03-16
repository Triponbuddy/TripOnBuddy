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

struct CustomTabButton: View {
    var imageName: String
    var imageNameFilled: String
    var isActive: Bool
    @Namespace private var animationNameSpace
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                
                VStack(spacing: 4){
                    
                    Image(systemName: isActive ? imageNameFilled : imageName)
                        .resizable()
                        .frame(width: isActive ? 27 : 25, height: isActive ? 27 : 25)
                        .foregroundColor(isActive ? Color(red: 0.984, green: 0.442, blue: 0.152): .gray)
                        .animation(.bouncy, value: isActive)
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(isActive ? Color(red: 0.984, green: 0.442, blue: 0.152) : Color.gray)
            }
        }
        
    }
}

#Preview {
    CustomTabButton(imageName: "plus.square", imageNameFilled: "plus.square.fill", isActive: true)
}

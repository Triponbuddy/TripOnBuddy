//
//  TripsTabBarButton.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 01/04/24.
//

import SwiftUI

struct TripsTabBarButton: View {
    var name: String
    var isActive: Bool
    @Namespace private var animationNameSpace
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                
                VStack(spacing: 4){
                    
                    Text(name)
                        .font(.title2)
                        .fontWeight(isActive ? .regular : .light)
                       .animation(.easeInOut, value: isActive)
                    if isActive {
                        Capsule()
                            .frame(width: 10, height: 5)
                            .animation(.easeInOut, value: isActive)
                        
                    }
                }
                .foregroundColor(colorScheme == .light ? Color.nileBlue : .white)
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        
    }
}

#Preview {
    TripsTabBarButton(name: "Completed", isActive: true)
}

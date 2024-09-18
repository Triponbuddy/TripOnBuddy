//
//  SignUpView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                //BackgroundView()
                VStack(alignment: .center) {
                    Image("TOB")
                        .resizable()
                        .frame(width: 220, height: 250)
                    
                    
                    
                }
                
                
            }
            
        }
        
    }
}

#Preview {
    SignUpView()
}

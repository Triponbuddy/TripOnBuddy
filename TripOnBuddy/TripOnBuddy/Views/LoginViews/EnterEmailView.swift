//
//  EnterEmailView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 26/04/24.
//

import SwiftUI

struct EnterEmailView: View {
    
    @State var emailId: String = ""
    @State var isTapped: Bool = false
    @FocusState var isFocus: Bool
    @Environment(\.dismiss) var dismiss
    @State private var fullScreenView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                
                Text("Enter Your Email Id")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 20)
                
                CustomTextFieldView(inputText: $emailId, infoText: "Your Email ID...*", isTapped: $isTapped)
                    .autocapitalization(.none)
                    .focused($isFocus)
                
                if !emailId.isEmpty {
                    
                    CustomButtonTemplate(name: "Create Account", width: 350, color: .nileBlue, paddingTop: 40)
                        .onTapGesture(perform: {
                            
                            fullScreenView = true
                            
                        })
                    
                }
                
                else {
                    
                    CustomButtonTemplate(name: "Create Account", width: 350, color: .gray, paddingTop: 40)
                    
                }
                
                Spacer()
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $fullScreenView, 
                             content: {
                RootView(selectedTab: .mySpace)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, 
                            content: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                })
            })
            
        }
        
    }
}

#Preview {
    EnterEmailView()
}

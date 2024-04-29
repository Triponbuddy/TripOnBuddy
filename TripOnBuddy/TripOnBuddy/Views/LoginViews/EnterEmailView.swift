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
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextFieldView(inputText: $emailId, infoText: "Your Email ID...*", isTapped: $isTapped)
                    .autocapitalization(.none)
                    .focused($isFocus)
                if !emailId.isEmpty {
                    NavigationLink(destination: {
                        Text("Next Page")
                    }, label: {
                        CustomButtonTemplate(name: "Next", width: 350, color: .nileBlue, paddingTop: 50)
                    })
                }
                else {
                    CustomButtonTemplate(name: "Next", width: 350, color: .gray, paddingTop: 50)
                }
                Spacer()
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
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

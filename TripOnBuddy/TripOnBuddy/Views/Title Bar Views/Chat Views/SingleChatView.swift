//
//  SingleChatView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 03/06/24.
//

import SwiftUI


struct SingleChatView: View {
    
    @State var sentMessages: [String] = ["Hello There!"]
    @State var message: String = ""
    @State private var isTapped: Bool = false
    @State private var isSent: Bool = false
    @FocusState var isFocus: Bool
    @Binding var userName: String
    @Environment(\.dismiss) var dismiss
    @State private var newMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.trailing, 10)
                Text(userName)
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "video")
                        .imageScale(.large)
                    
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName: "phone")
                        .imageScale(.large)
                    
                })
                
            }
            VStack {
                if isSent && !message.isEmpty {
                    VStack(alignment: .trailing) {
                        Text(message)
                            .padding()
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 10)
                            )
                            .frame(alignment: .trailing)
                    }
                }
                
            }
            Spacer()
            HStack {
                if !isTapped {
                    Button(action: {
                        isTapped = true
                    }, label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .symbolEffect(.scale)
                    })
                    TextField("Type Your Message here", text: $message)
                        .padding()
                        .background(Capsule()
                            .foregroundStyle(.gray.opacity(0.4))
                        )
                        .focused($isFocus)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isSent = true
                        }
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .symbolEffect(.bounce, value: isSent)
                    })
                }
                else {
                    VStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isTapped = false
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                                .symbolEffect(.bounce, value: isTapped)
                        })
                        // add code to open a menu to share file to the person
                    }
                    TextField("Type Your Message here", text: $message)
                        .padding()
                        .background(Capsule()
                            .foregroundStyle(.gray.opacity(0.4))
                        )
                        .focused($isFocus)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isSent = true
                            newMessage = sentNewMessages()
                            sentMessages.append(newMessage)
                        }
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundStyle(message.isEmpty ? Color.nileBlue : .gray.opacity(0.4))
                            .symbolEffect(.bounce, value: isSent)
                    })
                }
            }
            
        }
        .padding(8)
        .foregroundStyle(Color.nileBlue)
        .buttonStyle(SimpleButtonStyle())
        .navigationBarBackButtonHidden()
    }
    
    // function to add message to sentmessages
    func sentNewMessages() -> String {
        newMessage = message
        return newMessage
    }
}

#Preview {
    SingleChatView(userName: .constant("Sunil Sharma"))
    
}

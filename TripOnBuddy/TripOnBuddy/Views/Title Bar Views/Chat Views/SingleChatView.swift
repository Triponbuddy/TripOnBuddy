//
//  SingleChatView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 03/06/24.
//

import SwiftUI


struct SingleChatView: View {
    @State var message: String = ""
    @State private var isTapped: Bool = false
    @State private var isSent: Bool = false
    @FocusState var isFocus: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Full Name")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "video")
                    
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName: "phone")
                    
                })
                
            }
            Spacer()
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
                        }
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .symbolEffect(.bounce, value: isSent)
                    })
                }
            }
            
        }
        .padding(8)
        .foregroundStyle(Color.nileBlue)
        .buttonStyle(SimpleButtonStyle())
    }
}

#Preview {
    SingleChatView()
    
}

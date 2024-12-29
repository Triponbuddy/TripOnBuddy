//
//  RootViewModel.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 2024-12-28.
//

import Foundation
import SwiftUI

class RootViewModel: ObservableObject {
    @Published var selectedTab: Tabs = .mySpace

    func toolbarContent() -> some ToolbarContent {
        
        // Trailing: Notification bell and Chat bubble
        return ToolbarItemGroup(placement: .navigationBarTrailing) {
            HStack(spacing: 20) {
                NavigationLink(destination: NotificationsView()) {
                    Image(systemName: "bell")
                        .imageScale(.large)
                }
                NavigationLink(destination: AllChatsView()) {
                    Image(systemName: "message")
                        .imageScale(.large)
                }
            }
        }
    }


}

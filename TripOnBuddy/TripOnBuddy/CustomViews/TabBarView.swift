//
//  TabBarView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 17/03/24.
//

import SwiftUI
enum Tabs: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tabs, rhs: Tabs) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case mySpace, explore, post, trips, profile
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .mySpace:
            return "house.fill"
        case .explore:
            return "safari.fill"
        case .post:
            return "plus.square.fill"
        case .trips:
            return "backpack.fill"
        case .profile:
            return "person.crop.circle.fill"
        }
    }
  
}

let backgroundColor = Color.init(white: 0.92)

struct TabBarView: View {
    @Binding var selectedTab: Tabs
    @State var isActive: Bool = false
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.clear)
                .shadow(color: .gray.opacity(0.4), radius: 20, x: 0, y: 20)
            
            TabsLayoutView()
        }
        .frame(height: 70, alignment: .center)
    }
}
fileprivate struct TabsLayoutView: View {
    @State var selectedTab: Tabs = .mySpace
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tabs.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .frame(width: 65, height: 65, alignment: .center)
                Spacer(minLength: 0)
            }
        }
    }
    
    
    
    private struct TabButton: View {
        let tab: Tabs
        @Binding var selectedTab: Tabs
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        Capsule()
                            .shadow(radius: 10)
                            .frame(width: 80, height: 60)
                            .background {
                                Capsule()
                                    .stroke(lineWidth: 15)
                                    .foregroundStyle(.background)
                            }
                            .offset(y: 0)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.spring(), value: selectedTab)
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                        .scaleEffect(isSelected ? 1 : 0.7)
                        //.offset(y: isSelected ? -40 : 0)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}
#Preview {
    TabBarView(selectedTab: .constant(.profile))
}

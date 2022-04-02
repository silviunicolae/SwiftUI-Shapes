//
//  CustomTabBarView.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 25.09.2021.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @State var currentTab: Tab = .animation
    
    // Hide native Tab Bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Matched Geometry Effect
    @Namespace var animation
    
    var body: some View {
        TabView(selection: $currentTab) {
            NavigationView {
                AnimationTabView()
            }
            .tag(Tab.animation)
            
            NavigationView {
                DesignTabView()
            }
            .tag(Tab.design)
            
            Text("Notifications View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("SecondaryLight").ignoresSafeArea())
                .tag(Tab.notifications)
            
            Text("Profile View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("LightBlue").ignoresSafeArea())
                .tag(Tab.profile)
        }.overlay(
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                }
                .padding(.vertical)
                .padding(.bottom, getSafeArea().bottom == 0 ? 5 : (getSafeArea().bottom - 5))
                .background(
                    MaterialEffect(style: .systemThinMaterial)
                )
            },
            alignment: .bottom
        ).ignoresSafeArea(.all, edges: .bottom)
    }
    
    // Tab Button
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        
        GeometryReader { proxy in
            
            Button(action: {
                withAnimation(.spring()) {
                    currentTab = tab
                }
            }) {
                VStack(spacing: 2) {
                    Image(systemName: currentTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == tab ? .primary : .secondary)
                        .padding(currentTab == tab ? 15 : 0)
                        .background(
                            ZStack {
                                if currentTab == tab {
                                    MaterialEffect(style: .systemMaterial)
                                        .clipShape(Circle())
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            })
                        .contentShape(Rectangle())
                        .offset(y: currentTab == tab ? -25 : 0)
                    
                    if currentTab != tab {
                        Text(tab.tabName)
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
            }
        }.frame(height: 25)
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}


// Tab Bar enums
enum Tab: String, CaseIterable {
    
    case animation = "line.3.crossed.swirl.circle"
    case design = "doc.richtext"
    case notifications = "bell"
    case profile = "person"
    
    var tabName: String {
        switch self {
        case .animation:
            return "Animation"
        case .design:
            return "Design"
        case .notifications:
            return "Notifications"
        case .profile:
            return "Profile"
        }
    }
}

// Safe Area
extension View {
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

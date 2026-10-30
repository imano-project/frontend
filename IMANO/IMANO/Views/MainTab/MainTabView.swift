//
//  MainTabView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI

struct MainTabView : View {
    // MARK: - Properties
    @State private var selectedTab: TabItem = .home
    // MARK: - body
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label(TabItem.home.title, image:TabItem.home.iconName)
                }
                .tag(TabItem.home)
            RuleView()
                .tabItem {
                    Label(TabItem.rule.title, image:TabItem.rule.iconName)
                }
                .tag(TabItem.rule)
            SettingView()
                .tabItem {
                    Label(TabItem.settings.title, image:TabItem.settings.iconName)
                }
                .tag(TabItem.settings)
        }
    }
}

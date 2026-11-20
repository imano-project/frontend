//
//  MainTabView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI

struct MainTabView: View {

    // MARK: - Properties
    @State private var selectedTab: TabItem = .home

    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedTab) {

            // MARK: - Home
            HomeView()
                .tabItem {
                    Image(TabItem.home.iconName)
                }
                .tag(TabItem.home)

            // MARK: - Rule
            RuleView()
                .tabItem {
                    Image(TabItem.rule.iconName)
                }
                .tag(TabItem.rule)

            // MARK: - Settings
            SettingView()
                .tabItem {
                    Image(TabItem.settings.iconName)
                }
                .tag(TabItem.settings)
        }
        .tint(Color.main)
    }
}

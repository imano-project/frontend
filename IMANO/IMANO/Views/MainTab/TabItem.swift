//
//  TabItem.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI

// MARK: - Type
enum TabItem: Hashable {
    case home
    case rule
    case settings

    var title: String {
        switch self {
        case .home: return "ホーム"
        case .rule: return "ルール"
        case .settings: return "設定"
        }
    }
    var iconName: String {
        switch self {
        case .home: return "icon_home"
        case .rule: return "icon_rule"
        case .settings: return "icon_setting"
        }
    }
}


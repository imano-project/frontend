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
    var iconName: String {
        switch self {
        case .home: return "icon_home"
        case .rule: return "icon_rule"
        case .settings: return "icon_setting"
        }
    }
}


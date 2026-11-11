//
//  RuleModels.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/11.
//

import Foundation

struct RuleResponse: Decodable {
    let rules: [UserRule]
}

struct UserRule: Decodable, Identifiable {
    let id: String
    let name: String
    let type: String
    let enabled: Bool
    let condition: RuleCondition
    let action: RuleAction
}

struct RuleCondition: Decodable {
    let placeId: String?
    let keywords: [String]?
}

struct RuleAction: Decodable {
    let minutes: Int?
    let minutesBefore: Int?
}

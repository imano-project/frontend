//
//  WeatherInfo.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/06.
//

import Foundation

struct WeatherInfo {

    // MARK: - Properties
    let temperature: Double
    let condition: String
    let symbolName: String
    let highTemperature: Double?
    let lowTemperature: Double?
    let precipitationChance: Double?
    let updatedAt: Date
}

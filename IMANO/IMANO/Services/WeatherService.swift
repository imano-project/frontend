//
//  WeatherService.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/06.
//

import Foundation
import WeatherKit
import CoreLocation

final class WeatherService {

    // MARK: - Properties
    private let service = WeatherKit.WeatherService.shared

    // MARK: - Fetch Weather
    func fetchWeather(for location: CLLocation) async throws -> WeatherInfo {
        let weather = try await service.weather(for: location)
        let current = weather.currentWeather
        let today = weather.dailyForecast.forecast.first
        let hourly = weather.hourlyForecast.forecast.first

        return WeatherInfo(
            temperature: current.temperature.value,
            condition: current.condition.description,
            symbolName: current.symbolName,
            highTemperature: today?.highTemperature.value ?? 0,
            lowTemperature: today?.lowTemperature.value ?? 0,
            precipitationChance: hourly?.precipitationChance ?? 0,
            updatedAt: current.metadata.date
        )
    }
}

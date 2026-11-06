//
//  WeatherViewModel.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/06.
//

import SwiftUI
import Combine
import CoreLocation

final class WeatherViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var weatherInfo: WeatherInfo?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let weatherService = WeatherService()

    // MARK: - Fetch Weather
    func fetchWeather(for location: CLLocation) {
        Task {
            await fetchWeatherAsync(for: location)
        }
    }

    // MARK: - Private Methods
    private func fetchWeatherAsync(for location: CLLocation) async {
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }
        do {
            let weather = try await weatherService.fetchWeather(for: location)
            await MainActor.run {
                weatherInfo = weather
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
    }
}

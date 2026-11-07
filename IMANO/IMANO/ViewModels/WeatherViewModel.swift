//
//  WeatherViewModel.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/06.
//

import SwiftUI
import Combine
import CoreLocation

@MainActor
final class WeatherViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var weatherInfo: WeatherInfo?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let weatherService = WeatherService()
    private var fetchTask: Task<Void, Never>?
    private var latestRequestID = UUID()

    // MARK: - Fetch Weather
    func fetchWeather(for location: CLLocation) {
        fetchTask?.cancel()
        let requestID = UUID()
        latestRequestID = requestID
        isLoading = true
        errorMessage = nil
        fetchTask = Task { [weak self] in
            guard let self else { return }
            do {
                let weather = try await weatherService.fetchWeather(for: location)
                guard !Task.isCancelled, requestID == latestRequestID else { return }
                weatherInfo = weather
            } catch is CancellationError {
                return
            } catch {
                guard !Task.isCancelled, requestID == latestRequestID else { return }
                errorMessage = error.localizedDescription
            }
            guard !Task.isCancelled, requestID == latestRequestID else { return }
            isLoading = false
            fetchTask = nil
        }
    }
}

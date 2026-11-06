//
//  HomeViewModel.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/06.
//

import SwiftUI
import CoreLocation
import Combine

final class HomeViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var locationInfo: LocationInfo?
    @Published private(set) var movementState: MovementState = .unknown
    @Published private(set) var weatherInfo: WeatherInfo?
    @Published private(set) var isWeatherLoading = false
    @Published private(set) var weatherErrorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let locationViewModel = LocationViewModel()
    private let weatherViewModel = WeatherViewModel()

    // MARK: - Initializer
    init() {
        setupBindings()
    }

    // MARK: - Methods
    func startMonitoring() {
        locationViewModel.requestLocationPermission()
        locationViewModel.startMonitoring()
    }

    // MARK: - Private Methods
    private func setupBindings() {
        // 位置情報の監視
        locationViewModel.$locationInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self else { return }
                self.locationInfo = location
                guard let location else { return }
                let coordinate = CLLocation(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                self.weatherViewModel.fetchWeather(for: coordinate)
            }
            .store(in: &cancellables)
        // 移動状態の監視
        locationViewModel.$movementState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.movementState = state
            }
            .store(in: &cancellables)
        // 天気情報の監視
        weatherViewModel.$weatherInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                self?.weatherInfo = weather
            }
            .store(in: &cancellables)
        // 天気取得中の状態を監視
        weatherViewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.isWeatherLoading = isLoading
            }
            .store(in: &cancellables)
        // 天気取得エラーを監視
        weatherViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.weatherErrorMessage = message
            }
            .store(in: &cancellables)
    }
}

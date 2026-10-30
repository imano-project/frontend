//
//  LocationViewModel.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/30.
//

import SwiftUI
import Combine
import CoreLocation

final class LocationViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var locationInfo: LocationInfo?
    @Published private(set) var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published private(set) var errorMessage: String?

    private var previousLocation: CLLocation?

    private let locationService = LocationService()
    private let movementThreshold: CLLocationDistance = 100

    // MARK: - Initializer
    init() {
        setupLocationService()
    }
}

extension LocationViewModel {
    func requestLocationPermission() {
        locationService.requestPermission()
    }
    func startLocationUpdates() {
        locationService.startUpdatingLocation()
    }
    func stopLocationUpdates() {
        locationService.stopUpdatingLocation()
    }
}

// MARK: - Private Methods
private extension LocationViewModel {
    func setupLocationService() {
        locationService.onLocationUpdate = { [weak self] location in
            self?.handleLocationUpdate(location)
        }
        locationService.onAuthorizationChange = { [weak self] status in
            DispatchQueue.main.async {
                self?.authorizationStatus = status
            }
        }
        locationService.onLocationError = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    func handleLocationUpdate(_ location: CLLocation) {
        DispatchQueue.main.async {
            guard let previousLocation = self.previousLocation else {
                self.updateLocation(location)
                return
            }
            let distance = location.distance(from: previousLocation)
            guard distance >= self.movementThreshold else {
                return
            }
            self.updateLocation(location)
        }
    }

    func updateLocation(_ location: CLLocation) {
        previousLocation = location
        locationInfo = LocationInfo(location: location)
        errorMessage = nil
    }
}

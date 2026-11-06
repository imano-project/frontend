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
    @Published private(set) var movementState: MovementState = .unknown

    private var hasRequestedInitialLocation = false
    private var hasReceivedInitialLocation = false
    private var previousLocation: CLLocation?
    private let locationService = LocationService()
    private let motionService = MotionService()
    private let movementThreshold: CLLocationDistance = 100

    // MARK: - Initializer
    init() {
        setupLocationService()
        setupMotionService()
    }
}

// MARK: - Public Methods
extension LocationViewModel {
    func requestLocationPermission() {
        locationService.requestPermission()
    }

    func startMonitoring() {
        motionService.startMonitoring()
    }

    func stopMonitoring() {
        motionService.stopMonitoring()
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
                guard let self else { return }
                self.authorizationStatus = status
                let isAuthorized = status == .authorizedWhenInUse ||
                status == .authorizedAlways
                if isAuthorized && !self.hasRequestedInitialLocation {
                    self.hasRequestedInitialLocation = true
                    self.locationService.requestLocation()
                }
                self.updateLocationMonitoring()
            }
        }
        locationService.onLocationError = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    func setupMotionService() {
        motionService.onActivityUpdate = { [weak self] state in
            guard let self else { return }
            DispatchQueue.main.async {
                self.movementState = state
                self.updateLocationMonitoring()
            }
        }
    }

    func updateLocationMonitoring() {
        let isAuthorized = authorizationStatus == .authorizedWhenInUse ||
        authorizationStatus == .authorizedAlways
        guard isAuthorized else {
            locationService.stopUpdatingLocation()
            return
        }
        if !hasReceivedInitialLocation {
            locationService.startUpdatingLocation()
        } else if movementState.isMoving {
            locationService.startUpdatingLocation()
        } else {
            locationService.stopUpdatingLocation()
        }
    }

    func handleLocationUpdate(_ location: CLLocation) {
        DispatchQueue.main.async {
            self.hasReceivedInitialLocation = true
            guard let previousLocation = self.previousLocation else {
                self.updateLocation(location)
                self.updateLocationMonitoring()
                return
            }
            let distance = location.distance(from: previousLocation)
            guard distance >= self.movementThreshold else {
                self.updateLocationMonitoring()
                return
            }
            self.updateLocation(location)
            self.updateLocationMonitoring()
        }
    }

    func updateLocation(_ location: CLLocation) {
        previousLocation = location
        locationInfo = LocationInfo(location: location)
        errorMessage = nil
    }
}

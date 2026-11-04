//
//  LocationService.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/30.
//

import CoreLocation

final class LocationService: NSObject {

    // MARK: - Properties
    var onLocationUpdate: ((CLLocation) -> Void)?
    var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?
    var onLocationError: ((Error) -> Void)?

    private let locationManager = CLLocationManager()

    // MARK: - Initializer
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100
    }
}

extension LocationService {
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}
// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        onAuthorizationChange?(manager.authorizationStatus)
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        default:
            stopUpdatingLocation()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        onLocationError?(error)
    }
}

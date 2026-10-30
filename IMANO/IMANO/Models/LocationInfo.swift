//
//  LocationInfo.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/30.
//

import CoreLocation

struct LocationInfo {

    // MARK: - Properties
    let latitude: Double
    let longitude: Double
    let updatedAt: Date

    // MARK: - Initializer
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        updatedAt = location.timestamp
    }
}

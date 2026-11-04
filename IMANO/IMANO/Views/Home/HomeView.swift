//
//  HomeView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    @StateObject private var dateViewModel = DateViewModel()
    @StateObject private var locationViewModel = LocationViewModel()

    // MARK: - body
    var body: some View {
        VStack {
            // MARK: - Date
            Text(dateViewModel.dateText)
            Text(dateViewModel.timeText)

            // MARK: - Location
            if let location = locationViewModel.locationInfo {
                Text("緯度: \(location.latitude)")
                Text("経度: \(location.longitude)")
            } else {
                Text("位置情報を取得していません")
            }

            // MARK: - Movement
            Text("移動状態: \(String(describing: locationViewModel.movementState))")
        }
        .onAppear {
            locationViewModel.requestLocationPermission()
            locationViewModel.startMonitoring()
        }
    }
}

//
//  HomeView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    
    // MARK: - Properties
    @Environment(\.scenePhase) private var scenePhase
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
            } else if locationViewModel.authorizationStatus == .denied ||
                        locationViewModel.authorizationStatus == .restricted {
                Text("位置情報へのアクセスが許可されていません。設定から位置情報を許可してください。")
            } else if let errorMessage = locationViewModel.errorMessage {
                Text("位置情報を取得できませんでした: \(errorMessage)")
                Button("位置情報を再取得") {
                    locationViewModel.retryLocationRequest()
                }
            } else if locationViewModel.authorizationStatus == .notDetermined {
                Text("位置情報の利用許可を確認しています")
            } else {
                Text("位置情報を取得しています")
            }
            
            // MARK: - Movement
            Text("移動状態: \(String(describing: locationViewModel.movementState))")
        }
        .onAppear {
            locationViewModel.requestLocationPermission()
            locationViewModel.startMonitoring()
        }
        .onChange(of: scenePhase) { newPhase in
            guard newPhase == .active else { return }
            dateViewModel.refresh()
        }
    }
}

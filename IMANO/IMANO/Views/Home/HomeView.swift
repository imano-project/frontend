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
    @StateObject private var homeViewModel = HomeViewModel()

    // MARK: - body
    var body: some View {
        VStack {
            // MARK: - Date
            Text(dateViewModel.dateText)
            Text(dateViewModel.timeText)
            
            // MARK: - Location
            if let location = homeViewModel.locationInfo {
                Text("緯度: \(location.latitude)")
                Text("経度: \(location.longitude)")
            } else if homeViewModel.authorizationStatus == .denied ||
                        homeViewModel.authorizationStatus == .restricted {
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
            Text("移動状態: \(String(describing: homeViewModel.movementState))")

            // MARK: - Weather
            if homeViewModel.isWeatherLoading {
                Text("天気を取得中...")
            } else if let weather = homeViewModel.weatherInfo {
                Text("天気: \(weather.condition)")
                Text("気温: \(weather.temperature)℃")
                Text("最高気温: \(weather.highTemperature)℃")
                Text("最低気温: \(weather.lowTemperature)℃")
                Text("降水確率: \(Int(weather.precipitationChance * 100))%")
            } else if let error = homeViewModel.weatherErrorMessage {
                Text("天気取得エラー: \(error)")
            } else {
                Text("天気情報を取得していません")
            }
        }
        .onAppear {
            homeViewModel.startMonitoring()
        }
        .onChange(of: scenePhase) { newPhase in
            guard newPhase == .active else { return }
            dateViewModel.refresh()
        }
    }
}

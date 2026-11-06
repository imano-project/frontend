//
//  HomeView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI
import _LocationEssentials

struct HomeView: View {

    // MARK: - Properties
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
            } else {
                Text("位置情報を取得していません")
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
    }
}

//
//  HomeHeaderView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/09.
//

import SwiftUI

struct HomeHeaderView: View {

    // MARK: - Properties
    let yearText: String
    let monthText: String
    let dayText: String
    let weekdayText: String
    let currentActivityText: String
    let weatherInfo: WeatherInfo?

    // MARK: - Body
    var body: some View {
        VStack(spacing: 8) {

            // MARK: - Header Content
            ZStack {

                // MARK: - Current Activity
                Text(currentActivityText)
                    .font(AppFonts.body)
                    .foregroundStyle(.text)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )

                // MARK: - Date & Weather & Navigation Button
                HStack(spacing: 0) {

                    // MARK: - Date
                    HStack(alignment: .bottom, spacing: 2) {
                        Text(yearText + "年")
                            .font(AppFonts.body)
                            .foregroundStyle(.text)

                        Text(monthText + "月")
                            .font(AppFonts.body)
                            .foregroundStyle(.text)

                        Text(dayText)
                            .font(AppFonts.buttonText)
                            .foregroundStyle(.text)

                        Text("日（\(weekdayText)）")
                            .font(AppFonts.body)
                            .foregroundStyle(.text)
                    }
                    .offset(y: -5)

                    Spacer(minLength: 4)

                    // MARK: - Weather
                    if let weatherInfo {
                        HStack(spacing: 4) {
                            Image(systemName: weatherInfo.symbolName)
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 25))

                            Text("\(Int(weatherInfo.temperature.rounded()))°")
                                .font(AppFonts.body)
                                .foregroundStyle(.text)
                        }
                        .padding(.trailing, 12)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(
                            "\(weatherInfo.condition)、\(Int(weatherInfo.temperature.rounded()))度"
                        )
                    }

                    // MARK: - Navigation Button
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 76)
                        .background(Color(.mainButton))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 6)
                        )
                }
            }
            .frame(height: 80)
        }
        .foregroundStyle(.black)
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color(.main))
                .frame(height: 1)
        }
    }
}

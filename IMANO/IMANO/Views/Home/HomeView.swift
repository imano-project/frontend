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
    @State private var isShowingFreeTime = true

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Fixed Header
            HomeHeaderView(
                yearText: dateViewModel.yearText,
                monthText: dateViewModel.monthText,
                dayText: dateViewModel.dayText,
                weekdayText: dateViewModel.weekdayText
            )

            // MARK: - Free Time
            HStack {
                Spacer()
                HomeFreeTimeView(
                    isShowingFreeTime: $isShowingFreeTime
                )
            }
            .padding(.horizontal, 31)
            .padding(.vertical, 8)

            // MARK: - Scroll Content
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: - Schedule
                    ScheduleListView()
                }
            }
        }
    }
}

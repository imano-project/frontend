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
    @State private var isShowingAddSchedule = false

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
            // MARK: - Add Schedule Button
            Button {
                isShowingAddSchedule = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(.mainButton))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.mainButton), lineWidth: 1)
                    }
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $isShowingAddSchedule) {
            AddScheduleView()
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
        }
    }
}

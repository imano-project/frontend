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

    @State private var isShowingFreeTime = false
    @State private var isShowingAddSchedule = false
    @State private var selectedFreeTime: FreeTimeItem?
    @State private var schedules = ScheduleSampleData.create()

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(.background)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: - Header
                TimelineView(.periodic(from: .now, by: 60)) { context in
                    HomeHeaderView(
                        yearText: dateViewModel.yearText,
                        monthText: dateViewModel.monthText,
                        dayText: dateViewModel.dayText,
                        weekdayText: dateViewModel.weekdayText,
                        currentActivityText: currentActivityText(
                            at: context.date
                        )
                    )
                }

                // MARK: - Free Time Toggle
                HStack {
                    Spacer()

                    HomeFreeTimeView(
                        isShowingFreeTime: $isShowingFreeTime
                    )
                }
                .padding(.horizontal, 31)
                .padding(.vertical, 8)

                // MARK: - Schedule List
                VStack(spacing: 16) {
                    ScheduleListView(
                        schedules: $schedules,
                        isShowingFreeTime: isShowingFreeTime
                    ) { freeTime in
                        selectedFreeTime = freeTime
                        isShowingAddSchedule = true
                    }
                }
            }

            // MARK: - Add Schedule Button
            Button {
                selectedFreeTime = nil
                isShowingAddSchedule = true
            } label: {
                Image(systemName: "plus")
                    .font(
                        .system(
                            size: 28,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(.mainButton))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                Color(.mainButton),
                                lineWidth: 1
                            )
                    }
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $isShowingAddSchedule) {
            AddScheduleView(
                onAdd: { newSchedule in
                    addSchedule(newSchedule)
                },
                initialStartDate: selectedFreeTime?.startDate,
                initialEndDate: selectedFreeTime?.endDate
            )
            .presentationDetents([
                .fraction(0.75),
                .large
            ])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            homeViewModel.startMonitoring()
        }
        .onChange(of: scenePhase) { newPhase in
            guard newPhase == .active else {
                return
            }

            dateViewModel.refresh()
        }
    }

    // MARK: - Current Activity
    private func currentActivityText(at date: Date) -> String {
        guard let schedule = schedules.first(where: {
            $0.isCurrent(at: date)
        }) else {
            return "今何してる？"
        }

        return schedule.title + "中"
    }

    // MARK: - Add Schedule
    private func addSchedule(_ schedule: ScheduleDisplayItem) {
        schedules.append(schedule)
        schedules.sort {
            $0.startDate < $1.startDate
        }
    }
}

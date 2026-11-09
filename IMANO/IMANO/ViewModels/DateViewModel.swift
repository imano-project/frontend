//
//  DateViewModel.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/30.
//

import SwiftUI
import Combine

final class DateViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var yearText = ""
    @Published private(set) var monthText = ""
    @Published private(set) var dayText = ""
    @Published private(set) var weekdayText = ""

    @Published private(set) var timeText = ""

    private var timer: AnyCancellable?
    private let dateService = DateService()

    // MARK: - Initializer
    init() {
        updateDate()
        startTimer()
    }

    func refresh() {
        updateDate()
    }
}

// MARK: - Private Method
private extension DateViewModel {
    func updateDate() {
        let currentDate = Date()
        let calendar = Calendar.current
        yearText = String(calendar.component(.year, from: currentDate))
        monthText = String(calendar.component(.month, from: currentDate))
        dayText = String(calendar.component(.day, from: currentDate))
        let weekday = calendar.component(.weekday, from: currentDate)
        weekdayText = dateService.weekdayName(for: weekday)
        timeText = dateService.formattedTime(from: currentDate)
    }

    func startTimer() {
        let now = Date()
        let nextMinute = Calendar.current.nextDate(
            after: now,
            matching: DateComponents(second: 0),
            matchingPolicy: .nextTime
        ) ?? now.addingTimeInterval(60)
        let interval = nextMinute.timeIntervalSince(now)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
            guard let self else { return }
            self.updateDate()
            self.timer = Timer.publish(every: 60, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.updateDate()
                }
        }
    }
}

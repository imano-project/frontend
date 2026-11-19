//
//  FreeTimeItem.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//


import Foundation

// MARK: - Free Time Model
struct FreeTimeItem: Identifiable {

    // MARK: - Properties
    let id: String
    let startDate: Date
    let endDate: Date
    let suggestedActivity: String?

    // MARK: - Duration
    var durationMinutes: Int {
        Int(endDate.timeIntervalSince(startDate) / 60)
    }

    // MARK: - Time
    var timeText: String {
        let start = startDate.formatted(
            .dateTime.hour().minute()
                .locale(Locale(identifier: "ja_JP"))
        )
        let end = endDate.formatted(
            .dateTime.hour().minute()
                .locale(Locale(identifier: "ja_JP"))
        )
        return "\(start)〜\(end)"
    }
}

// MARK: - Free Time Service
struct FreeTimeService {

    // MARK: - Properties
    private let minimumDuration = 15
    private let suggestionDuration = 30

    // MARK: - Calculate Free Time
    func calculate(
        from schedules: [ScheduleDisplayItem]
    ) -> [FreeTimeItem] {
        let sortedSchedules = schedules.sorted {
            $0.startDate < $1.startDate
        }
        guard sortedSchedules.count >= 2 else {
            return []
        }
        var freeTimes: [FreeTimeItem] = []
        var previousEndDate = sortedSchedules[0].endDate
        for index in 1..<sortedSchedules.count {
            let nextSchedule = sortedSchedules[index]
            let startDate = previousEndDate
            let endDate = nextSchedule.startDate
            let duration = Int(
                endDate.timeIntervalSince(startDate) / 60
            )
            if duration >= minimumDuration {
                let suggestion: String?
                if duration >= suggestionDuration {
                    suggestion = suggestedActivity(for: startDate)
                } else {
                    suggestion = nil
                }
                freeTimes.append(
                    FreeTimeItem(
                        id: "free_\(index)",
                        startDate: startDate,
                        endDate: endDate,
                        suggestedActivity: suggestion
                    )
                )
            }
            previousEndDate = max(
                previousEndDate,
                nextSchedule.endDate
            )
        }
        return freeTimes
    }

    // MARK: - Suggested Activity
    private func suggestedActivity(
        for date: Date
    ) -> String? {
        let hour = Calendar.current.component(
            .hour,
            from: date
        )
        switch hour {
        case 6..<10:
            return "いつもこの時間は身支度してるよ"
        case 10..<12:
            return "いつもこの時間は勉強してるよ"
        case 12..<15:
            return "いつもこの時間は休憩してるよ"
        case 15..<18:
            return "いつもこの時間はカフェに行ってるよ"
        case 18..<21:
            return "いつもこの時間は動画を見てるよ"
        case 21..<24:
            return "いつもこの時間は読書してるよ"
        default:
            return nil
        }
    }
}

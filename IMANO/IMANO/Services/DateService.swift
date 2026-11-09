//
//  DateService.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/30.
//

import Foundation

struct DateService {
    
    // MARK: - Date Formatting
    func formattedDate(from date: Date) -> String {
        date.formatted(
            .dateTime
                .year()
                .month()
                .day()
                .weekday(.wide)
                .locale(Locale(identifier: "ja_JP"))
        )
    }
    
    func formattedTime(from date: Date) -> String {
        date.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ja_JP"))
        )
    }
    
    // MARK: - Weekday
    func weekdayName(for weekday: Int) -> String {
        let weekdays = ["日", "月", "火", "水", "木", "金", "土"]
        guard (1...7).contains(weekday) else { return "" }
        return weekdays[weekday - 1]
    }
}

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
}

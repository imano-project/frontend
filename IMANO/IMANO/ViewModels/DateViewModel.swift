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
    @Published private(set) var dateText = ""
    @Published private(set) var timeText = ""

    private let dateService = DateService()

    func updateDate(_ date: Date) {
        dateText = dateService.formattedDate(from: date)
        timeText = dateService.formattedTime(from: date)
    }
}

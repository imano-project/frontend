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

    private var timer: AnyCancellable?
    private let dateService = DateService()

    // MARK: - Initializer
    init() {
        updateDate()
        startTimer()
    }
}

// MARK: - Private Method
private extension DateViewModel {
    func updateDate() {
        let currentDate = Date()
        dateText = dateService.formattedDate(from: currentDate)
        timeText = dateService.formattedTime(from: currentDate)
    }
    func startTimer() {
        timer = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink {[weak self] _ in
                self?.updateDate( )
            }
    }
}

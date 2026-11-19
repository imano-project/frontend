//
//  ScheduleListView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/10.
//

import SwiftUI

// MARK: - Schedule Size
enum ScheduleCardSize {
    case large
    case medium
    case small
    var height: CGFloat {
        switch self {
        case .large:
            60
        case .medium:
            53
        case .small:
            45
        }
    }
}

// MARK: - Schedule Model
struct ScheduleDisplayItem: Identifiable {

    // MARK: - Properties
    let id: String
    var title: String
    var startDate: Date
    var endDate: Date
    var place: String
    var type: String
    var memo: String
    var size: ScheduleCardSize

    // MARK: - Category
    var category: ScheduleCategory {
        ScheduleCategory.detect(from: title)
    }

    // MARK: - Time
    var startTimeText: String {
        startDate.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ja_JP"))
        )
    }
    var endTimeText: String {
        endDate.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ja_JP"))
        )
    }
    var timeText: String {
        "\(startTimeText)〜\(endTimeText)"
    }

    // MARK: - Current Schedule
    func isCurrent(at date: Date) -> Bool {
        startDate <= date && date < endDate
    }
}

// MARK: - Schedule List View
struct ScheduleListView: View {

    // MARK: - Properties
    @Binding var schedules: [ScheduleDisplayItem]
    let isShowingFreeTime: Bool
    private let freeTimeService = FreeTimeService()
    private var sortedSchedules: [ScheduleDisplayItem] {
        schedules.sorted { $0.startDate < $1.startDate }
    }
    private var freeTimes: [FreeTimeItem] {
        freeTimeService.calculate(from: sortedSchedules)
    }

    // MARK: - Body
    var body: some View {
        ScrollViewReader { proxy in
            TimelineView(.periodic(from: .now, by: 60)) { context in
                let currentDate = context.date
                let currentScheduleID = sortedSchedules.first {
                    $0.isCurrent(at: currentDate)
                }?.id
                let nextScheduleID = sortedSchedules.first {
                    $0.startDate > currentDate
                }?.id
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(
                            Array(sortedSchedules.enumerated()),
                            id: \.element.id
                        ) { index, schedule in

                            // MARK: - Schedule Card
                            let size = cardSize(
                                for: schedule,
                                at: currentDate,
                                nextScheduleID: nextScheduleID
                            )
                            ScheduleCardView(
                                schedule: schedule,
                                size: size
                            )
                            .id(schedule.id)

                            // MARK: - Free Time Card
                            if isShowingFreeTime,
                               index < sortedSchedules.count - 1 {
                                let nextSchedule = sortedSchedules[index + 1]
                                if let freeTime = freeTimes.first(where: {
                                    $0.startDate == schedule.endDate &&
                                        $0.endDate == nextSchedule.startDate &&
                                        $0.endDate > currentDate
                                }) {
                                    FreeTimeCardView(
                                        freeTime: freeTime
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
                .onAppear {
                    if let targetID = currentScheduleID ?? nextScheduleID {
                        DispatchQueue.main.async {
                            proxy.scrollTo(
                                targetID,
                                anchor: UnitPoint(x: 0.5, y: 0.3)
                            )
                        }
                    }
                }
            }
        }
    }

    // MARK: - Card Size
    private func cardSize(
        for schedule: ScheduleDisplayItem,
        at date: Date,
        nextScheduleID: String?
    ) -> ScheduleCardSize {
        if schedule.isCurrent(at: date) {
            return .large
        }
        if schedule.id == nextScheduleID {
            return .medium
        }
        return .small
    }
}

// MARK: - Schedule Card View
struct ScheduleCardView: View {

    // MARK: - Properties
    let schedule: ScheduleDisplayItem
    let size: ScheduleCardSize
    private var isHighlighted: Bool {
        size == .large || size == .medium
    }
    private var textColor: Color {
        isHighlighted ? .white : Color.text
    }
    private var iconSize: CGFloat {
        isHighlighted ? 60 : 35
    }
    private var backgroundColor: Color {
        isHighlighted ? schedule.category.color : .white
    }

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            // MARK: - Category Icon
            Image(systemName: schedule.category.iconName)
                .font(.system(size: iconSize))
                .foregroundStyle(schedule.category.color)
                .frame(width: 65)

            // MARK: - Schedule Card
            VStack(alignment: .leading, spacing: 4) {
                if isHighlighted {

                    // MARK: - Large & Medium
                    HStack(
                        alignment: .firstTextBaseline,
                        spacing: 10
                    ) {
                        Text(schedule.timeText)
                            .font(AppFonts.largeTime)
                            .fixedSize(
                                horizontal: true,
                                vertical: false
                            )
                        Text(schedule.title)
                            .font(AppFonts.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }

                    // MARK: - Place
                    if !schedule.place.isEmpty {
                        Label(
                            schedule.place,
                            systemImage: "mappin"
                        )
                        .font(AppFonts.largeDescription)
                        .lineLimit(1)
                    }

                    // MARK: - Memo
                    if !schedule.memo.isEmpty {
                        Label(
                            schedule.memo,
                            systemImage: "note.text"
                        )
                        .font(AppFonts.largeDescription)
                        .lineLimit(1)
                    }
                } else {

                    // MARK: - Small
                    Text(schedule.timeText)
                        .font(AppFonts.time)
                    Text(schedule.title)
                        .font(AppFonts.title)
                        .lineLimit(1)
                }
            }
            .foregroundStyle(textColor)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(.horizontal, 12)
            .padding(.vertical, isHighlighted ? 8 : 4)
            .frame(
                minHeight: size.height,
                alignment: .center
            )
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 6)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(
                        schedule.category.color,
                        lineWidth: 2
                    )
            }
        }
        .frame(maxWidth: .infinity)
    }
}

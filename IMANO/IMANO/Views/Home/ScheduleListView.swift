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
        case .large: 70
        case .medium: 53
        case .small: 45
        }
    }
}

// MARK: - Schedule Model
struct ScheduleDisplayItem: Identifiable {
    let id: String
    let title: String
    let startTime: String
    let endTime: String
    let place: String
    let type: String
    let size: ScheduleCardSize
}

// MARK: - Schedule Card Style
struct ScheduleCardStyle {
    let borderColor: Color
    let backgroundColor: Color
    let textColor: Color
    static let current = ScheduleCardStyle(
        borderColor: Color(.mainButton),
        backgroundColor: Color(.mainButton),
        textColor: .white
    )
    static let next = ScheduleCardStyle(
        borderColor: Color(.mainButton),
        backgroundColor: Color(.gray),
        textColor: Color(.text)
    )
    static let other = ScheduleCardStyle(
        borderColor: Color(.mainButton),
        backgroundColor: Color(.gray),
        textColor: Color(.text)
    )
}

// MARK: - Schedule List View
struct ScheduleListView: View {
    
    // MARK: - Properties
    private let schedules: [ScheduleDisplayItem] = [
        ScheduleDisplayItem(
            id: "schedule_001",
            title: "朝の準備",
            startTime: "06:30",
            endTime: "07:00",
            place: "家",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_002",
            title: "朝食",
            startTime: "07:00",
            endTime: "07:20",
            place: "家",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_003",
            title: "身支度",
            startTime: "07:20",
            endTime: "07:40",
            place: "家",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_004",
            title: "家から駅へ移動",
            startTime: "07:40",
            endTime: "08:00",
            place: "駅",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_005",
            title: "駅から学校へ移動",
            startTime: "08:00",
            endTime: "08:45",
            place: "学校",
            type: "行動予測",
            size: .large
        ),
        ScheduleDisplayItem(
            id: "schedule_006",
            title: "学校で過ごす",
            startTime: "09:00",
            endTime: "16:00",
            place: "学校",
            type: "登録予定",
            size: .medium
        ),
        ScheduleDisplayItem(
            id: "schedule_007",
            title: "学校から駅へ移動",
            startTime: "16:10",
            endTime: "16:35",
            place: "駅",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_008",
            title: "買い物",
            startTime: "16:40",
            endTime: "17:00",
            place: "スーパー",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_009",
            title: "駅から家へ移動",
            startTime: "17:00",
            endTime: "17:20",
            place: "家",
            type: "行動予測",
            size: .small
        ),
        ScheduleDisplayItem(
            id: "schedule_010",
            title: "夕食",
            startTime: "18:00",
            endTime: "19:00",
            place: "家",
            type: "行動予測",
            size: .small
        )
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            ForEach(schedules) { schedule in
                ScheduleCardView(schedule: schedule)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Schedule Card View
struct ScheduleCardView: View {
    
    // MARK: - Properties
    let schedule: ScheduleDisplayItem
    private var backgroundColor: Color {
        switch schedule.size {
        case .large:
            Color(.mainButton)
        case .medium, .small:
            Color(.gray)
        }
    }
    private var RectangleColor: Color {
        switch schedule.size {
        case .large:
            Color(.mainButton)
        case .medium, .small:
            Color(.gray)
        }
    }
    private var textColor: Color {
        switch schedule.size {
        case .large:
                .white
        case .medium, .small:
            Color(.text)
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(schedule.startTime) - \(schedule.endTime)")
                    .font(AppFonts.body)
                Spacer()
                if schedule.size != .small {
                    Text(schedule.type)
                        .font(AppFonts.body)
                }
            }
            .foregroundStyle(textColor)
            Text(schedule.title)
                .font(
                    schedule.size == .large
                    ? .title3
                    : schedule.size == .medium
                    ? .body
                    : .subheadline
                )
                .fontWeight(.semibold)
                .foregroundStyle(textColor)
            if schedule.size != .small {
                Label(schedule.place, systemImage: "mappin")
                    .font(.caption)
                    .foregroundStyle(textColor)
            }
        }
        .padding(schedule.size == .large ? 16 : 12)
        .frame(maxWidth: .infinity)
        .frame(height: schedule.size.height)
        .background(backgroundColor)
        .overlay {
            Rectangle()
                .stroke(Color(RectangleColor), lineWidth: 1)
        }
    }
}

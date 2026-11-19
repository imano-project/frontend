//
//  ScheduleSampleData.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//

import Foundation

enum ScheduleSampleData {
    
    // MARK: - Sample Schedules
    static func create() -> [ScheduleDisplayItem] {
        
        // MARK: - Date
        func date(_ hour: Int, _ minute: Int) -> Date {
            Calendar.current.date(
                bySettingHour: hour,
                minute: minute,
                second: 0,
                of: Date()
            )!
        }
        return [
            
            // MARK: - Morning
            ScheduleDisplayItem(
                id: "001",
                title: "起床",
                startDate: date(7, 0),
                endDate: date(7, 10),
                place: "自宅",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "002",
                title: "朝ごはん",
                startDate: date(7, 10),
                endDate: date(7, 40),
                place: "自宅",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "003",
                title: "身支度",
                startDate: date(7, 40),
                endDate: date(8, 10),
                place: "自宅",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "004",
                title: "学校へ移動",
                startDate: date(8, 10),
                endDate: date(8, 55),
                place: "学校",
                type: "行動予測",
                memo: "電車で移動",
                size: .small
            ),
            
            // MARK: - School
            ScheduleDisplayItem(
                id: "005",
                title: "授業",
                startDate: date(9, 0),
                endDate: date(10, 30),
                place: "学校",
                type: "登録予定",
                memo: "チーム開発",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "006",
                title: "休憩",
                startDate: date(10, 30),
                endDate: date(10, 45),
                place: "学校",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "007",
                title: "授業",
                startDate: date(10, 45),
                endDate: date(12, 15),
                place: "学校",
                type: "登録予定",
                memo: "アプリ開発",
                size: .small
            ),
            
            // MARK: - Lunch
            ScheduleDisplayItem(
                id: "008",
                title: "お昼ごはん",
                startDate: date(12, 15),
                endDate: date(13, 0),
                place: "学食",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            
            // MARK: - Afternoon
            ScheduleDisplayItem(
                id: "009",
                title: "課題",
                startDate: date(13, 0),
                endDate: date(14, 30),
                place: "学校",
                type: "登録予定",
                memo: "SwiftUIの実装",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "010",
                title: "カフェ",
                startDate: date(14, 45),
                endDate: date(15, 30),
                place: "駅前カフェ",
                type: "登録予定",
                memo: "友達と休憩",
                size: .small
            ),
            
            // MARK: - Evening
            ScheduleDisplayItem(
                id: "011",
                title: "買い物",
                startDate: date(16, 0),
                endDate: date(16, 45),
                place: "ショッピングモール",
                type: "登録予定",
                memo: "日用品を買う",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "012",
                title: "帰宅",
                startDate: date(17, 0),
                endDate: date(17, 45),
                place: "自宅",
                type: "行動予測",
                memo: "電車で移動",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "013",
                title: "夜ごはん",
                startDate: date(18, 30),
                endDate: date(19, 15),
                place: "自宅",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            
            // MARK: - Night
            ScheduleDisplayItem(
                id: "014",
                title: "お風呂",
                startDate: date(20, 0),
                endDate: date(20, 30),
                place: "自宅",
                type: "行動予測",
                memo: "",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "015",
                title: "自由時間",
                startDate: date(20, 30),
                endDate: date(22, 30),
                place: "自宅",
                type: "行動予測",
                memo: "動画・読書",
                size: .small
            ),
            ScheduleDisplayItem(
                id: "016",
                title: "就寝",
                startDate: date(23, 0),
                endDate: date(23, 30),
                place: "自宅",
                type: "行動予測",
                memo: "",
                size: .small
            )
        ]
    }
}

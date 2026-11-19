//
//  ScheduleCategory.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//

import SwiftUI

// MARK: - Schedule Category
enum ScheduleCategory {
    case wakeUp
    case breakfast
    case lunch
    case dinner
    case cafe
    case preparation
    case school
    case study
    case work
    case transportation
    case exercise
    case shopping
    case social
    case home
    case bath
    case freeTime
    case sleep
    case other

    // MARK: - Color
    var color: Color {
        switch self {
        case .wakeUp:
            Color(red: 0.894, green: 0.604, blue: 0.263)
        case .breakfast:
            Color(red: 0.902, green: 0.627, blue: 0.361)
        case .lunch:
            Color(red: 0.894, green: 0.498, blue: 0.404)
        case .dinner:
            Color(red: 0.851, green: 0.427, blue: 0.525)
        case .cafe:
            Color(red: 0.769, green: 0.498, blue: 0.616)
        case .preparation:
            Color(red: 0.694, green: 0.518, blue: 0.839)
        case .school:
            Color(red: 0.388, green: 0.561, blue: 0.878)
        case .study:
            Color(red: 0.502, green: 0.490, blue: 0.835)
        case .work:
            Color(red: 0.318, green: 0.549, blue: 0.725)
        case .transportation:
            Color(red: 0.302, green: 0.651, blue: 0.780)
        case .exercise:
            Color(red: 0.306, green: 0.604, blue: 0.843)
        case .shopping:
            Color(red: 0.831, green: 0.631, blue: 0.247)
        case .social:
            Color(red: 0.310, green: 0.686, blue: 0.533)
        case .home:
            Color(red: 0.541, green: 0.576, blue: 0.655)
        case .bath:
            Color(red: 0.329, green: 0.678, blue: 0.733)
        case .freeTime:
            Color(red: 0.659, green: 0.486, blue: 0.812)
        case .sleep:
            Color(red: 0.533, green: 0.447, blue: 0.780)
        case .other:
            Color(red: 0.463, green: 0.686, blue: 0.627)
        }
    }

    // MARK: - Icon
    var iconName: String {
        switch self {
        case .wakeUp:
            "sun.max"
        case .breakfast:
            "sunrise"
        case .lunch:
            "fork.knife"
        case .dinner:
            "moon.stars"
        case .cafe:
            "cup.and.saucer"
        case .preparation:
            "tshirt"
        case .school:
            "building.2"
        case .study:
            "book.closed"
        case .work:
            "briefcase"
        case .transportation:
            "tram.fill"
        case .exercise:
            "figure.run"
        case .shopping:
            "cart"
        case .social:
            "figure.2.arms.open"
        case .home:
            "house"
        case .bath:
            "bathtub"
        case .freeTime:
            "sparkles"
        case .sleep:
            "moon.zzz"
        case .other:
            "calendar"
        }
    }

    // MARK: - Keyword Detection
    static func detect(from title: String) -> ScheduleCategory {
        let rules: [(ScheduleCategory, [String])] = [

            // MARK: - Wake Up
            (
                .wakeUp,
                ["起床", "目覚め", "朝起き", "起きる"]
            ),

            // MARK: - Breakfast
            (
                .breakfast,
                ["朝ごはん", "朝ご飯", "朝食", "モーニング"]
            ),

            // MARK: - Lunch
            (
                .lunch,
                ["昼ごはん", "昼ご飯", "昼食", "ランチ",
                 "お昼ごはん", "お昼ご飯"]
            ),

            // MARK: - Dinner
            (
                .dinner,
                ["夜ごはん", "夜ご飯", "夕食", "晩ごはん",
                 "晩ご飯", "ディナー"]
            ),

            // MARK: - Cafe
            (
                .cafe,
                ["カフェ", "喫茶店", "コーヒー", "お茶"]
            ),

            // MARK: - Preparation
            (
                .preparation,
                ["身支度", "準備", "着替え", "メイク", "化粧"]
            ),

            // MARK: - Transportation
            (
                .transportation,
                ["移動", "電車", "バス", "通勤", "通学", "乗車"]
            ),

            // MARK: - School
            (
                .school,
                ["授業", "講義", "登校", "学校", "ゼミ"]
            ),

            // MARK: - Study
            (
                .study,
                ["課題", "勉強", "自習", "レポート", "学習",
                 "プログラミング", "開発"]
            ),

            // MARK: - Work
            (
                .work,
                ["仕事", "バイト", "アルバイト", "勤務", "出勤"]
            ),

            // MARK: - Exercise
            (
                .exercise,
                ["ランニング", "ジョギング", "運動", "ジム",
                 "筋トレ", "散歩", "ウォーキング"]
            ),

            // MARK: - Shopping
            (
                .shopping,
                ["買い物", "買物", "スーパー", "購入",
                 "ショッピング"]
            ),

            // MARK: - Social
            (
                .social,
                ["友達", "遊び", "デート", "会う", "お出かけ",
                 "食事会", "飲み会"]
            ),

            // MARK: - Home
            (
                .home,
                ["帰宅", "帰る", "家に帰", "帰省"]
            ),

            // MARK: - Bath
            (
                .bath,
                ["お風呂", "入浴", "シャワー", "半身浴"]
            ),

            // MARK: - Free Time
            (
                .freeTime,
                ["自由時間", "休憩", "趣味", "ゲーム",
                 "動画", "読書", "リラックス"]
            ),

            // MARK: - Sleep
            (
                .sleep,
                ["就寝", "睡眠", "寝る", "おやすみ", "仮眠"]
            )
        ]

        // MARK: - Detect Category
        for (category, keywords) in rules {
            if keywords.contains(where: {
                title.localizedCaseInsensitiveContains($0)
            }) {
                return category
            }
        }

        return .other
    }
}

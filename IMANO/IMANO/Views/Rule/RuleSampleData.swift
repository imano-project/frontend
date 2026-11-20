//
//  RuleSampleData.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/20.
//



import Foundation

// MARK: - Rule Sample Data
enum RuleSampleData {

    // MARK: - Create
    static func create() -> [UserRule] {
        let json = """
        {
          "rules": [
            {
              "id": "ru_01",
              "name": "お母さんに連絡",
              "memo": "学校を出る時点で19時までに帰れなさそうならお母さんに連絡する",
              "type": "departure_notification",
              "enabled": true,
              "condition": {
                "placeId": "pl_school",
                "keywords": ["家", "お母さん"]
              },
              "action": {
                "minutesBefore": 10
              }
            },
            {
              "id": "ru_02",
              "name": "バイト10分前到着",
              "memo": null,
              "type": "arrival_buffer",
              "enabled": false,
              "condition": {
                "placeId": "pl_work",
                "keywords": ["バイト", "アルバイト", "仕事"]
              },
              "action": {
                "minutes": 10
              }
            },
            {
              "id": "ru_03",
              "name": "バイト30分前通知",
              "memo": "バイトの日は出発時間を早めに確認する",
              "type": "departure_notification",
              "enabled": true,
              "condition": {
                "placeId": "pl_work",
                "keywords": ["バイト", "アルバイト", "仕事"]
              },
              "action": {
                "minutesBefore": 30
              }
            },
            {
              "id": "ru_04",
              "name": "みさきちゃんと待ち合わせ通知",
              "memo": "待ち合わせに遅れないようにする",
              "type": "departure_notification",
              "enabled": true,
              "condition": {
                "keywords": ["みさきちゃん", "遊び", "待ち合わせ"]
              },
              "action": {
                "minutesBefore": 60
              }
            },
            {
              "id": "ru_05",
              "name": "学校に忘れ物しない",
              "memo": "学校へ行く前に持ち物を確認する",
              "type": "departure_notification",
              "enabled": true,
              "condition": {
                "placeId": "pl_school",
                "keywords": ["学校", "忘れ物", "持ち物"]
              },
              "action": {
                "minutesBefore": 5
              }
            },
            {
              "id": "ru_06",
              "name": "授業開始前に到着",
              "memo": null,
              "type": "arrival_buffer",
              "enabled": true,
              "condition": {
                "placeId": "pl_school",
                "keywords": ["授業", "学校"]
              },
              "action": {
                "minutes": 15
              }
            },
            {
              "id": "ru_07",
              "name": "病院の予約を通知",
              "memo": "診察券と保険証を忘れずに持っていく",
              "type": "departure_notification",
              "enabled": false,
              "condition": {
                "keywords": ["病院", "診察", "予約"]
              },
              "action": {
                "minutesBefore": 60
              }
            },
            {
              "id": "ru_08",
              "name": "映画館に早めに到着",
              "memo": "上映前に飲み物を買う時間を確保する",
              "type": "arrival_buffer",
              "enabled": true,
              "condition": {
                "keywords": ["映画", "映画館"]
              },
              "action": {
                "minutes": 20
              }
            },
            {
              "id": "ru_09",
              "name": "ジムに行く時間を通知",
              "memo": null,
              "type": "departure_notification",
              "enabled": false,
              "condition": {
                "keywords": ["ジム", "運動", "トレーニング"]
              },
              "action": {
                "minutesBefore": 30
              }
            },
            {
              "id": "ru_10",
              "name": "友達との約束に遅れない",
              "memo": "集合時間より少し早めに到着する",
              "type": "arrival_buffer",
              "enabled": false,
              "condition": {
                "keywords": ["友達", "遊び", "約束"]
              },
              "action": {
                "minutes": 10
              }
            }
          ]
        }
        """

        guard let data = json.data(using: .utf8),
              let response = try? JSONDecoder().decode(
                RuleResponse.self,
                from: data
              ) else {
            return []
        }

        return response.rules
    }
}

//
//  RuleCardView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/10.
//

import SwiftUI

// MARK: - Rule Card View
struct RuleCardView: View {

    // MARK: - Properties
    let rule: UserRule

    // MARK: - Notification Rule
    private var isNotificationRule: Bool {
        rule.type == "departure_notification"
    }

    // MARK: - Border Color
    private var borderColor: Color {
        rule.enabled ? Color(.main) : Color.gray.opacity(0.4)
    }

    // MARK: - Place Name
    private var placeName: String {
        switch rule.condition.placeId {
        case "pl_school":
            return "学校"
        case "pl_work":
            return "職場"
        case nil:
            return "なし"
        default:
            return rule.condition.placeId ?? "なし"
        }
    }

    // MARK: - Action Time
    private var actionTimeText: String {
        switch rule.type {
        case "arrival_buffer":
            if let minutes = rule.action.minutes {
                return "到着：\(minutes)分前"
            }
            return "到着：設定なし"

        case "departure_notification":
            if let minutes = rule.action.minutesBefore {
                return "通知：\(minutes)分前"
            }
            return "通知：設定なし"

        default:
            return "設定なし"
        }
    }

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 8) {

            // MARK: - Rule Content
            VStack(alignment: .leading, spacing: 3) {

                // MARK: - Rule Name
                Text(rule.name)
                    .font(AppFonts.subheading)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                // MARK: - Memo
                if let memo = rule.memo, !memo.isEmpty {
                    Text(memo)
                        .font(Font.custom("RoundedMplus1c-Regular", size: 8))
                        .foregroundStyle(Color.text)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }

                Spacer(minLength: 0)

                // MARK: - Place
                Text("住所：\(placeName)")
                    .font(Font.custom("RoundedMplus1c-Regular", size: 6))
                    .foregroundStyle(Color.text)
                    .lineLimit(1)

                // MARK: - Keywords
                if let keywords = rule.condition.keywords,
                   !keywords.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(keywords, id: \.self) { keyword in
                                Text(keyword)
                                    .font(Font.custom("RoundedMplus1c-Regular", size: 6))
                                    .foregroundStyle(Color.text)
                                    .lineLimit(1)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Color(.systemGray5))
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 3)
                                    )
                            }
                        }
                    }
                }

                // MARK: - Action Time
                Text(actionTimeText)
                    .font(Font.custom("RoundedMplus1c-Regular", size: 6))
                    .foregroundStyle(Color.text)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // MARK: - Menu Button
            Button {
                // TODO: ルールの編集・削除メニューを実装
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black.opacity(0.7))
                    .rotationEffect(.degrees(90))
                    .frame(width: 30, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("ルールのメニュー")
        }
        .padding(10)
        .frame(height: 100)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))

        // MARK: - Border
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke(borderColor, lineWidth: 2)
                .allowsHitTesting(false)
        }

        // MARK: - Notification Icon
        .overlay(alignment: .topLeading) {
            if isNotificationRule {
                Image(systemName: "bell.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.yellow)
                    .offset(x: -8, y: -12)
                    .accessibilityHidden(true)
            }
        }
    }
}

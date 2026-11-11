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

    // MARK: - Action Description
    private var actionDescription: String {
        switch rule.type {
        case "arrival_buffer":
            if let minutes = rule.action.minutes {
                return "\(minutes)分前に到着"
            }
            return "到着時刻を調整"
        case "departure_notification":
            if let minutesBefore = rule.action.minutesBefore {
                return "\(minutesBefore)分前に出発を通知"
            }
            return "出発を通知"
        default:
            return rule.type
        }
    }

    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {

                // MARK: - Rule Name
                Text(rule.name)
                    .font(.headline)
                    .foregroundStyle(.primary)

                // MARK: - Action
                Text(actionDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                // MARK: - Keywords
                if let keywords = rule.condition.keywords,
                   !keywords.isEmpty {
                    Text("キーワード：\(keywords.joined(separator: "、"))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                // MARK: - Enabled Status
                Text(rule.enabled ? "有効" : "無効")
                    .font(.caption)
                    .foregroundStyle(
                        rule.enabled ? .green : .secondary
                    )
            }
            Spacer(minLength: 8)

            // MARK: - Menu Button
            Button {
                // TODO: ルールの編集・削除メニューを実装
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black.opacity(0.7))
                    .rotationEffect(.degrees(90))
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("ルールのメニュー")
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


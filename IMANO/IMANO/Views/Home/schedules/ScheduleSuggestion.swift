//
//  ScheduleSuggestion.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//



import SwiftUI

// MARK: - Schedule Suggestion
struct ScheduleSuggestion: Identifiable {

    // MARK: - Properties
    let id = UUID()
    let title: String
    let startDate: Date
    let endDate: Date

    // MARK: - Category
    var category: ScheduleCategory {
        ScheduleCategory.detect(from: title)
    }

    // MARK: - Time
    var timeText: String {
        let start = startDate.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ja_JP"))
        )

        let end = endDate.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ja_JP"))
        )

        return "\(start)〜\(end)"
    }

    // MARK: - Duration
    var durationMinutes: Int {
        Int(endDate.timeIntervalSince(startDate) / 60)
    }
}

// MARK: - Add Schedule Suggestion View
struct AddScheduleSuggestionView: View {

    // MARK: - Properties
    @Binding var title: String
    @Binding var startDate: Date
    @Binding var endDate: Date

    // MARK: - Sample Suggestions
    private var suggestions: [ScheduleSuggestion] {
        let calendar = Calendar.current
        let today = Date()

        func date(_ hour: Int, _ minute: Int) -> Date {
            calendar.date(
                bySettingHour: hour,
                minute: minute,
                second: 0,
                of: today
            )!
        }

        return [
            ScheduleSuggestion(
                title: "お昼ごはん",
                startDate: date(12, 0),
                endDate: date(13, 0)
            ),
            ScheduleSuggestion(
                title: "課題",
                startDate: date(13, 30),
                endDate: date(15, 0)
            ),
            ScheduleSuggestion(
                title: "カフェ",
                startDate: date(15, 30),
                endDate: date(16, 30)
            ),
            ScheduleSuggestion(
                title: "買い物",
                startDate: date(17, 0),
                endDate: date(18, 0)
            )
        ]
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // MARK: - Title
                Text("提案")
                    .font(AppFonts.heading)
                    .foregroundStyle(Color.text)

                // MARK: - Suggestion List
                VStack(spacing: 8) {
                    ForEach(suggestions) { suggestion in
                        Button {
                            selectSuggestion(suggestion)
                        } label: {
                            suggestionRow(suggestion)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        Color(.mainButton),
                        lineWidth: 1
                    )
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Suggestion Row
    private func suggestionRow(
        _ suggestion: ScheduleSuggestion
    ) -> some View {
        HStack(spacing: 12) {

            // MARK: - Icon
            Image(systemName: suggestion.category.iconName)
                .font(.system(size: 18))
                .foregroundStyle(suggestion.category.color)
                .frame(width: 40, height: 40)
                .background(
                    suggestion.category.color.opacity(0.12)
                )
                .clipShape(Circle())

            // MARK: - Content
            VStack(alignment: .leading, spacing: 4) {

                Text(
                    "\(suggestion.timeText) (\(suggestion.durationMinutes)分)"
                )
                .font(AppFonts.largeDescription)
                .foregroundStyle(.gray)

                Text(suggestion.title)
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
            }

            Spacer()

            // MARK: - Arrow
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }

    // MARK: - Select Suggestion
    private func selectSuggestion(
        _ suggestion: ScheduleSuggestion
    ) {
        title = suggestion.title
        startDate = suggestion.startDate
        endDate = suggestion.endDate
    }
}

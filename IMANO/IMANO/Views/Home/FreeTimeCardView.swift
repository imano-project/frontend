//
//  FreeTimeCardView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//

import SwiftUI

// MARK: - Free Time Card View
struct FreeTimeCardView: View {

    // MARK: - Properties
    let freeTime: FreeTimeItem
    private let backgroundColor = Color(
        red: 0.95,
        green: 0.95,
        blue: 0.96
    )
    private let textColor = Color(
        red: 0.45,
        green: 0.47,
        blue: 0.51
    )

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            // MARK: - Icon Space
            Color.clear
                .frame(width: 65, height: 1)

            // MARK: - Free Time Card
            VStack(alignment: .leading, spacing: 4) {

                // MARK: - Duration
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                    Text("空き時間 \(freeTime.durationMinutes)分")
                        .font(AppFonts.largeDescription)
                }

                // MARK: - Suggested Activity
                if let suggestedActivity = freeTime.suggestedActivity {
                    Text(suggestedActivity)
                        .font(AppFonts.largeDescription)
                        .lineLimit(2)
                }
            }
            .foregroundStyle(textColor)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 6)
            )
        }
        .frame(maxWidth: .infinity)
    }
}

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
    var onTap: () -> Void = {}

    // MARK: - Body
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 12) {

                // MARK: - Icon Space
                Color.clear
                    .frame(width: 65)

                // MARK: - Card
                VStack(alignment: .leading, spacing: 6) {

                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.system(size: 13))

                        Text("空き時間 \(freeTime.durationMinutes)分")
                            .font(AppFonts.largeDescription)

                        Spacer()

                        Image(systemName: "plus")
                            .font(.system(size: 13))
                    }

                    Text(freeTime.timeText)
                        .font(AppFonts.largeDescription)

                    if let suggestion = freeTime.suggestedActivity {
                        Text(suggestion)
                            .font(AppFonts.largeDescription)
                            .lineLimit(2)
                    }
                }
                .foregroundStyle(Color.gray)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color(
                        red: 0.95,
                        green: 0.95,
                        blue: 0.96
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 6)
                )
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

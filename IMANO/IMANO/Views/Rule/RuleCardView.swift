//
//  RuleCardView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/10.
//



import SwiftUI

// MARK: - Rule Card View
struct RuleCardView: View {

    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()

            // MARK: - Menu Button
            Button {
                // TODO: ルールのメニューを表示
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black.opacity(0.7))
                    .rotationEffect(.degrees(90))
                    .frame(width: 40, height: 40)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 81)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

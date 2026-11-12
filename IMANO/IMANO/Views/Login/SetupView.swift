//
//  SetupView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/11.
//


import SwiftUI

struct SetupView: View {

    // MARK: - Properties
    var onNext: () -> Void
    private let permissions: [(title: String, description: String)] = [
        (
            "位置情報",
            "現在地や移動状況を把握し、場所に合わせた情報を表示するために使用します。"
        ),
        (
            "モーションとフィットネス",
            "歩行や移動状態を検知し、生活の状況を把握するために使用します。"
        ),
        (
            "ライブアクティビティ",
            "必要な情報をリアルタイムで確認できるようにするために使用します。"
        ),
        (
            "トラッキング",
            "利用目的を確認したうえで、必要な場合のみ使用します。"
        )
    ]

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Progress Indicator
            HStack(spacing: 5) {
                ForEach(0..<4, id: \.self) { _ in
                    Capsule()
                        .fill(Color.text.opacity(0.15))
                        .frame(height: 10)
                }
            }
            .padding(.horizontal, 50)
            .padding(.top, 30)

            // MARK: - Title
            Text("許可が必要なもの")
                .font(AppFonts.body)
                .foregroundStyle(Color.text)
                .padding(.top, 45)

            // MARK: - Permission List
            VStack(spacing: 0) {
                ForEach(Array(permissions.enumerated()), id: \.offset) { index, permission in
                    VStack(spacing: 12) {
                        Text(permission.title)
                            .font(AppFonts.body)
                            .foregroundStyle(Color.text)
                        Text(permission.description)
                            .font(AppFonts.body)
                            .foregroundStyle(Color.text)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 12)
                    if index < permissions.count - 1 {
                        Divider()
                            .padding(.horizontal, 12)
                    }
                }
                Button {
                    onNext()
                } label: {
                    Text("次へ")
                        .font(AppFonts.body)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.main)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
            }
            .frame(maxHeight: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.main, lineWidth: 1)
            }
            .padding(.horizontal, 40)
            .padding(.top, 35)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

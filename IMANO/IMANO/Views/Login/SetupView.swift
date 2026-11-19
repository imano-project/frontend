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
            "現在地や移動状況を把握し、\n場所に合わせた情報を表示するために使用します。"
        ),
        (
            "モーションとフィットネス",
            "歩行や移動状態を検知し、\n生活の状況を把握するために使用します。"
        ),
        (
            "ライブアクティビティ",
            "必要な情報をリアルタイムで\n確認できるようにするために使用します。"
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
            SetupProgressBar(currentStep: 0)
                .padding(.top, 30)

            // MARK: - Title
            Text("許可が必要なもの")
                .font(AppFonts.heading)
                .foregroundStyle(Color.text)
                .padding(.top, 32)

            // MARK: - Permission List
            VStack(spacing: 0) {
                ForEach(Array(permissions.enumerated()), id: \.offset) { index, permission in
                    VStack(spacing: 12) {
                        Text(permission.title)
                            .font(AppFonts.subheading)
                            .foregroundStyle(Color.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(permission.description)
                            .font(AppFonts.sentence)
                            .foregroundStyle(Color.text)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 20)
                    if index < permissions.count - 1 {
                        Divider()
                            .padding(.horizontal, 12)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.main, lineWidth: 2)
            }
            .padding(.horizontal, 40)
            .padding(.top, 35)
            .padding(.bottom, 30)

            // MARK: - Action Buttons
            Button {
                onNext()
            } label: {
                Text("次へ")
                    .font(AppFonts.buttonText)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.mainButton)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.background)
                .ignoresSafeArea()
        }
    }
}

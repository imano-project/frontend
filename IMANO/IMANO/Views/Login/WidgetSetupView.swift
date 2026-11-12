//
//  WidgetSetupView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/12.
//



import SwiftUI

struct WidgetSetupView: View {

    // MARK: - Properties

    var onNext: () -> Void
    var onSkip: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Progress Indicator

            HStack(spacing: 5) {
                ForEach(0..<4, id: \.self) { index in
                    Capsule()
                        .fill(
                            index < 3
                            ? Color.main
                            : Color.gray.opacity(0.15)
                        )
                        .frame(height: 10)
                }
            }
            .padding(.horizontal, 50)
            .padding(.top, 30)

            // MARK: - Title

            VStack(spacing: 8) {
                Text("widgetを追加して下さい")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)

                Text("なぜ登録が必要なのかの説明")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 45)

            Spacer()

            // MARK: - Widget Illustration

            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.main, lineWidth: 1)

                Text("widget追加のイラスト")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 580)
            .padding(.horizontal, 40)

            Spacer()

            // MARK: - Action Buttons

            VStack(spacing: 20) {

                Button {
                    onSkip()
                } label: {
                    Text("スキップ")
                        .font(AppFonts.body)
                        .foregroundStyle(Color.text)
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.text, lineWidth: 1)
                        }
                }

                Button {
                    onNext()
                } label: {
                    Text("次へ")
                        .font(AppFonts.body)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(
                            Color.main,
                            in: RoundedRectangle(cornerRadius: 6)
                        )
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

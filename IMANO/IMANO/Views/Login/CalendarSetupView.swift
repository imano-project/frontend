//
//  CalendarSetupView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/12.
//



import SwiftUI

struct CalendarSetupView: View {

    // MARK: - Properties

    var onNext: () -> Void
    var onSkip: () -> Void
    var onGoogleConnect: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Progress Indicator

            HStack(spacing: 5) {
                ForEach(0..<4, id: \.self) { index in
                    Capsule()
                        .fill(
                            index < 2
                            ? Color.main
                            : Color.gray.opacity(0.15)
                        )
                        .frame(height: 10)
                }
            }
            .padding(.horizontal, 50)
            .padding(.top, 30)

            // MARK: - Title

            VStack(spacing: 12) {
                Text("カレンダー連携")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)

                Text("なぜ連携が必要なのかの説明")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 45)

            Spacer()

            // MARK: - Google Calendar

            VStack(spacing: 18) {

                Text("googleカレンダー")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)

                Text("アカウントを連携して下さい")
                    .font(AppFonts.body)
                    .foregroundStyle(.secondary)

                // Google Connect Button

                Button {
                    onGoogleConnect()
                } label: {
                    HStack(spacing: 12) {
                        Text("G")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(Color.blue)

                        Text("Continue with Google")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.black)
                    }
                    .padding(.horizontal, 22)
                    .frame(height: 56)
                    .background(
                        Color.gray.opacity(0.10),
                        in: Capsule()
                    )
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 280)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.main, lineWidth: 1)
            }
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

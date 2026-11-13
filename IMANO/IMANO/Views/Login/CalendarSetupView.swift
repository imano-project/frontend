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
        GeometryReader { geometry in
            ZStack {

                // MARK: - Google Calendar
                VStack(spacing: 2) {
                    Text("Googleカレンダー")
                        .font(AppFonts.subheading)
                        .foregroundStyle(Color.text)
                    Text("アカウントを連携してください")
                        .font(AppFonts.sentence)
                        .foregroundStyle(.secondary)
                    Spacer()
                        .frame(height: 16)
                    // Google Connect Button
                    Button {
                        onGoogleConnect()
                    } label: {
                        HStack(spacing: 12) {
                            Image("icon_google")
                                .resizable()
                                .frame(width: 20, height: 20)
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
                .frame(width: 257, height: 175)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.main, lineWidth: 2)
                }
                // ディスプレイ全体の中央に配置
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )

                // MARK: - Header and Action Buttons
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
                    .padding(.top, max(geometry.safeAreaInsets.top, 59) + 30)

                    // MARK: - Title
                    VStack(spacing: 12) {
                        Text("カレンダー連携")
                            .font(AppFonts.heading)
                            .foregroundStyle(Color.text)
                        Text("予定を取得して、スケジュールに合わせた\n情報を表示するために、カレンダーを連携します。")
                            .font(AppFonts.body)
                            .foregroundStyle(Color.text)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 45)
                    Spacer()

                    // MARK: - Action Buttons
                    VStack(spacing: 20) {
                        Button {
                            onSkip()
                        } label: {
                            Text("スキップ")
                                .font(AppFonts.blackButtonText)
                                .foregroundStyle(Color.text)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.text, lineWidth: 1)
                                }
                        }
                        Button {
                            onNext()
                        } label: {
                            Text("次へ")
                                .font(AppFonts.buttonText)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    Color.mainButton,
                                    in: RoundedRectangle(cornerRadius: 6)
                                )
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 25)
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .background(Color(.background))
        }
        .ignoresSafeArea()
    }
}

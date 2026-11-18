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
            SetupProgressBar(currentStep: 3)
                .padding(.top, 30)

            // MARK: - Title
            VStack(spacing: 8) {
                Text("widgetを追加して下さい")
                    .font(AppFonts.heading)
                    .foregroundStyle(Color.text)
                Text("ウィジェットを追加すると、\nアプリを開かなくても、出発時間や\n雨の日の持ち物など、今必要な情報を確認できます。")
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 45)
            Spacer(minLength: 20)

            // MARK: - Widget Illustration
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.main, lineWidth: 1)
                Image("WidgetSetup")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 40)
            Spacer(minLength: 20)

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
                            Color.main,
                            in: RoundedRectangle(cornerRadius: 6)
                        )
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.background)
                .ignoresSafeArea()
        }
    }
}

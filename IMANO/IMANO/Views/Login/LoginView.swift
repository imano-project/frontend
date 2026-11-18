//
//  LoginView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/11.
//

import SwiftUI

struct LoginView: View {

    // MARK: - Properties
    var onTap: () -> Void

    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            VStack(spacing: 8) {
                Spacer()

                // MARK: - App Title
                Text("IMANO")
                    .font(AppFonts.logoText)
                    .foregroundStyle(Color(.text))

                // MARK: - App Description
                Text("今の自分に必要な情報だけ。")
                    .font(AppFonts.body)
                    .foregroundStyle(Color(.text))
                    .multilineTextAlignment(.center)
                Spacer()

                // MARK: - Start Guide
                Text("画面をタップして開始")
                    .font(AppFonts.body)
                Spacer()
                    .frame(height: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

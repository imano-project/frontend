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
            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 8) {

                    // MARK: - App Title
                    Text("IMANO")
                        .font(AppFonts.logoText)
                        .foregroundStyle(Color(.text))

                    // MARK: - App Description
                    Text("今の自分に必要な情報だけ。")
                        .font(AppFonts.body)
                        .foregroundStyle(Color(.text))
                        .multilineTextAlignment(.center)
                }
                .offset(y: -50)
                Spacer()

                // MARK: - Start Guide
                Text("画面をタップして開始")
                    .font(AppFonts.body)
                Spacer()
                    .frame(height: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.background)
                .ignoresSafeArea()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

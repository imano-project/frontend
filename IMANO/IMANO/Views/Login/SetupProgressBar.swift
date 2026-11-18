//
//  SetupProgressBar.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/13.
//

import SwiftUI

// MARK: - Setup Progress Bar
struct SetupProgressBar: View {

    // MARK: - Properties
    var currentStep: Int

    // MARK: - Body
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<4, id: \.self) { index in
                Capsule()
                    .fill(
                        index < currentStep
                        ? Color.main
                        : Color.gray.opacity(0.15)
                    )
                    .frame(height: 10)
            }
        }
        .padding(.horizontal, 50)
    }
}

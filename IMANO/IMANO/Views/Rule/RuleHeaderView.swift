//
//  RuleHeaderView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/10.
//

import SwiftUI

// MARK: - Rule Header View
struct RuleHeaderView: View {
    
    // MARK: - Body
    var body: some View {
        
        // MARK: - Header Content
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                
                // MARK: - Title
                Text("ユーザールール")
                    .font(AppFonts.heading)
                    .foregroundStyle(.text)
                Spacer()
                
                // MARK: - Help Button
                Button {
                    // TODO: 説明画面を表示
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 16))
                        .foregroundStyle(.text)
                }
                .buttonStyle(.plain)
            }
            
            // MARK: - Description
            Text("ユーザールールの説明文、この画面で何ができるのか")
                .font(AppFonts.sentence)
                .foregroundStyle(.text)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 80)
        .foregroundStyle(.black)
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color(.main))
                .frame(height: 1)
        }
    }
}

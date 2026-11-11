//
//  RuleView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI

// MARK: - Rule View
struct RuleView: View {

    // MARK: - Properties
    @State private var searchText = ""
    @State private var isShowingAddRule = false

    // 仮データ
    private let ruleItems = Array(0..<10)

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 0) {

                // MARK: - Fixed Header
                RuleHeaderView()

                // MARK: - Rule Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {

                        // MARK: - Search
                        RuleSearchView(searchText: $searchText)
                            .padding(.horizontal, 33)

                        // MARK: - Rule Count
                        Text("ユーザールール数：\(ruleItems.count)")
                            .font(AppFonts.sentence)
                            .foregroundStyle(.black)
                            .padding(.leading, 51)

                        // MARK: - Rule List
                        VStack(spacing: 4) {
                            ForEach(ruleItems, id: \.self) { _ in
                                RuleCardView()
                                    .padding(.horizontal, 51)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                    .padding(.bottom, 80)
                }
            }

            // MARK: - Add Button
            Button {
                isShowingAddRule = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(.mainButton))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $isShowingAddRule) {
            Text("ルール追加画面")
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
        }
    }
}


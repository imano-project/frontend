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
    @State private var rules = Self.loadSampleRules()

    // MARK: - Search Matching
    private func matchesSearch(_ text: String, query: String) -> Bool {
        let normalizedText = text.applyingTransform(
            .hiraganaToKatakana,
            reverse: false
        ) ?? text
        let normalizedQuery = query.applyingTransform(
            .hiraganaToKatakana,
            reverse: false
        ) ?? query
        return normalizedText.localizedCaseInsensitiveContains(normalizedQuery)
    }
    // MARK: - Filtered Rules
    private var filteredRules: [UserRule] {
        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !query.isEmpty else {
            return rules
        }
        return rules.filter { rule in
            matchesSearch(rule.name, query: query)
            || matchesSearch(rule.type, query: query)
            || (rule.condition.keywords ?? []).contains {
                matchesSearch($0, query: query)
            }
        }
    }

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
                    VStack(alignment: .leading, spacing: 12) {

                        // MARK: - Search
                        RuleSearchView(searchText: $searchText)

                        // MARK: - Rule Count
                        Text("ユーザールール数：\(rules.count)")
                            .font(AppFonts.sentence)
                            .foregroundStyle(.black)

                        // MARK: - Rule List
                        if filteredRules.isEmpty {
                            ContentUnavailableView(
                                searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                ? "ルールがありません"
                                : "検索結果がありません",
                                systemImage: searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                ? "list.bullet"
                                : "magnifyingglass"
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.top, 32)

                        } else {
                            LazyVStack(spacing: 8) {
                                ForEach(filteredRules) { rule in
                                    RuleCardView(rule: rule)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 96)
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
            .buttonStyle(.plain)
            .accessibilityLabel("ルールを追加")
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $isShowingAddRule) {
            Text("ルール追加画面")
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
        }
    }

    // MARK: - Sample Data
    private static func loadSampleRules() -> [UserRule] {
        let json = """
        {
          "rules": [
            {
              "id": "ru_01",
              "name": "バイトは10分前に到着",
              "type": "arrival_buffer",
              "enabled": true,
              "condition": {
                "placeId": "pl_work",
                "keywords": ["バイト", "アルバイト", "仕事"]
              },
              "action": {
                "minutes": 10
              }
            },
            {
              "id": "ru_02",
              "name": "バイトの出発通知",
              "type": "departure_notification",
              "enabled": true,
              "condition": {
                "placeId": "pl_work"
              },
              "action": {
                "minutesBefore": 15
              }
            }
          ]
        }
        """
        guard let data = json.data(using: .utf8),
              let response = try? JSONDecoder().decode(
                RuleResponse.self,
                from: data
              ) else {
            return []
        }
        return response.rules
    }
}

//
//  RuleView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI
import Foundation
import CoreFoundation

// MARK: - Rule View
struct RuleView: View {

    // MARK: - Properties
    @State private var searchText = ""
    @State private var isShowingAddRule = false
    @State private var editingRule: UserRule?
    @State private var rules = RuleSampleData.create()

    // MARK: - Search Aliases
    private let searchAliases: [String: String] = [
        "お母さん": "おかあさん",
        "お父さん": "おとうさん"
    ]

    // MARK: - Normalize Search Text
    private func normalizeSearchText(_ text: String) -> String {
        let normalized = text.applyingTransform(
            .hiraganaToKatakana,
            reverse: false
        ) ?? text

        return normalized
            .lowercased()
            .filter { !$0.isWhitespace }
    }

    // MARK: - Japanese Reading
    private func japaneseReading(_ text: String) -> String {
        let locale = CFLocaleCreate(
            kCFAllocatorDefault,
            CFLocaleIdentifier("ja_JP" as CFString)
        )

        let tokenizer = CFStringTokenizerCreate(
            kCFAllocatorDefault,
            text as CFString,
            CFRangeMake(0, (text as NSString).length),
            kCFStringTokenizerUnitWordBoundary,
            locale
        )

        var reading = ""

        var tokenType = CFStringTokenizerAdvanceToNextToken(
            tokenizer
        )

        while tokenType.rawValue != 0 {
            if let latinReading = CFStringTokenizerCopyCurrentTokenAttribute(
                tokenizer,
                kCFStringTokenizerAttributeLatinTranscription
            ) {
                let converted = latinReading as! String

                let hiragana = converted.applyingTransform(
                    StringTransform("Latin-Hiragana"),
                    reverse: false
                ) ?? converted

                reading += hiragana
            } else {
                let range = CFStringTokenizerGetCurrentTokenRange(
                    tokenizer
                )

                if range.location != kCFNotFound {
                    reading += (text as NSString).substring(
                        with: NSRange(
                            location: range.location,
                            length: range.length
                        )
                    )
                }
            }

            tokenType = CFStringTokenizerAdvanceToNextToken(
                tokenizer
            )
        }

        return normalizeSearchText(reading)
    }

    // MARK: - Search Matching
    private func matchesSearch(
        _ text: String,
        query: String
    ) -> Bool {
        let normalizedText = normalizeSearchText(text)
        let normalizedQuery = normalizeSearchText(query)

        // MARK: - Original Text
        if normalizedText.contains(normalizedQuery) {
            return true
        }

        // MARK: - Search Aliases
        for (word, reading) in searchAliases {
            if normalizedText.contains(normalizeSearchText(word))
                && normalizeSearchText(reading).contains(normalizedQuery) {
                return true
            }
        }

        // MARK: - Japanese Reading
        return japaneseReading(text).contains(normalizedQuery)
    }

    // MARK: - Place Name
    private func placeName(for placeId: String?) -> String {
        switch placeId {
        case "pl_home":
            return "自宅"

        case "pl_school":
            return "学校"

        case "pl_work":
            return "職場"

        default:
            return ""
        }
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
            || matchesSearch(rule.memo ?? "", query: query)
            || matchesSearch(
                placeName(for: rule.condition.placeId),
                query: query
            )
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
                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        // MARK: - Search
                        RuleSearchView(
                            searchText: $searchText
                        )

                        // MARK: - Rule Count
                        Text(
                            "ユーザールール数：\(filteredRules.count)"
                        )
                        .font(AppFonts.sentence)
                        .foregroundStyle(.black)

                        // MARK: - Rule List
                        if filteredRules.isEmpty {
                            ContentUnavailableView(
                                searchText.trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                ).isEmpty
                                ? "ルールがありません"
                                : "検索結果がありません",
                                systemImage: searchText.trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                ).isEmpty
                                ? "list.bullet"
                                : "magnifyingglass"
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.top, 32)

                        } else {
                            LazyVStack(spacing: 8) {
                                ForEach(filteredRules) { rule in
                                    Button {
                                        editingRule = rule
                                    } label: {
                                        RuleCardView(rule: rule)
                                    }
                                    .buttonStyle(.plain)
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
                    .font(
                        .system(
                            size: 28,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(.mainButton))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
            }
            .buttonStyle(.plain)
            .accessibilityLabel("ルールを追加")
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }

        // MARK: - Add Rule Sheet
        .sheet(isPresented: $isShowingAddRule) {
            AddRuleView { newRule in
                rules.insert(newRule, at: 0)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }

        // MARK: - Edit Rule Sheet
        .sheet(item: $editingRule) { rule in
            AddRuleView(editingRule: rule) { updatedRule in
                guard let index = rules.firstIndex(
                    where: { $0.id == updatedRule.id }
                ) else {
                    return
                }

                rules[index] = updatedRule
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

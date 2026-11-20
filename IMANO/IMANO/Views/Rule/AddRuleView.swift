//
//  AddRuleView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/20.
//

import SwiftUI

// MARK: - Add Rule View
struct AddRuleView: View {

    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss

    let editingRule: UserRule?
    let onSave: (UserRule) -> Void

    @State private var ruleName = ""
    @State private var selectedPlace = "指定なし"
    @State private var selectedType: RuleType = .notification
    @State private var minutes = 0
    @State private var keywords: [String] = []
    @State private var keywordInput = ""
    @State private var memo = ""

    // MARK: - Rule Type
    private enum RuleType: String, CaseIterable {
        case notification = "通知"
        case arrival = "到着"
    }

    // MARK: - Initializer
    init(
        editingRule: UserRule? = nil,
        onSave: @escaping (UserRule) -> Void
    ) {
        self.editingRule = editingRule
        self.onSave = onSave
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Form
            ScrollView {
                VStack(spacing: 14) {

                    // MARK: - Title
                    TextField("タイトル", text: $ruleName)
                        .font(AppFonts.body)
                        .padding(.horizontal, 14)
                        .frame(height: 42)
                        .background(Color(.systemGray6))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 4)
                        )

                    // MARK: - Form Card
                    VStack(alignment: .leading, spacing: 0) {

                        // MARK: - Place
                        VStack(alignment: .leading, spacing: 8) {
                            fieldTitle("場所")

                            Picker(
                                "場所",
                                selection: $selectedPlace
                            ) {
                                Text("指定なし").tag("指定なし")
                                Text("自宅").tag("自宅")
                                Text("学校").tag("学校")
                                Text("職場").tag("職場")
                            }
                            .pickerStyle(.menu)
                            .tint(.black)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .trailing
                            )
                        }
                        .padding(.vertical, 12)

                        Divider()

                        // MARK: - Rule Type
                        VStack(alignment: .leading, spacing: 12) {
                            Picker(
                                "ルール種別",
                                selection: $selectedType
                            ) {
                                ForEach(
                                    RuleType.allCases,
                                    id: \.self
                                ) { type in
                                    Text(type.rawValue)
                                        .tag(type)
                                }
                            }
                            .pickerStyle(.segmented)

                            HStack(spacing: 12) {
                                Text(selectedType.rawValue)
                                    .font(AppFonts.sentence)

                                TextField(
                                    "00",
                                    value: $minutes,
                                    format: .number
                                )
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(AppFonts.subheading)
                                .frame(width: 82, height: 48)
                                .background(Color(.systemGray6))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 4)
                                )

                                Text("分前")
                                    .font(AppFonts.sentence)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 14)

                        Divider()

                        // MARK: - Keywords
                        VStack(alignment: .leading, spacing: 8) {
                            fieldTitle("キーワード")

                            // MARK: - Keyword Tags
                            if !keywords.isEmpty {
                                FlowLayout(spacing: 6) {
                                    ForEach(
                                        keywords,
                                        id: \.self
                                    ) { keyword in
                                        HStack(spacing: 4) {
                                            Text(keyword)
                                                .font(AppFonts.sentence)
                                                .lineLimit(1)

                                            Button {
                                                keywords.removeAll {
                                                    $0 == keyword
                                                }
                                            } label: {
                                                Image(
                                                    systemName: "xmark"
                                                )
                                                .font(.system(size: 9))
                                                .foregroundStyle(.gray)
                                            }
                                            .buttonStyle(.plain)
                                            .accessibilityLabel(
                                                "\(keyword)を削除"
                                            )
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 6)
                                        .background(Color(.systemGray6))
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 4
                                            )
                                        )
                                    }
                                }
                            }

                            // MARK: - Keyword Input
                            HStack(spacing: 8) {
                                TextField(
                                    "キーワードを入力",
                                    text: $keywordInput
                                )
                                .font(AppFonts.sentence)
                                .submitLabel(.done)
                                .padding(.horizontal, 12)
                                .frame(height: 36)
                                .background(Color(.systemGray6))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 4)
                                )
                                .onSubmit {
                                    addKeyword()
                                }

                                Button {
                                    addKeyword()
                                } label: {
                                    Image(systemName: "plus")
                                        .font(
                                            .system(
                                                size: 16,
                                                weight: .medium
                                            )
                                        )
                                        .foregroundStyle(.white)
                                        .frame(
                                            width: 36,
                                            height: 36
                                        )
                                        .background(Color(.mainButton))
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 4
                                            )
                                        )
                                }
                                .buttonStyle(.plain)
                                .disabled(
                                    keywordInput.trimmingCharacters(
                                        in: .whitespacesAndNewlines
                                    ).isEmpty
                                )
                                .accessibilityLabel(
                                    "キーワードを追加"
                                )
                            }
                        }
                        .padding(.vertical, 14)

                        Divider()

                        // MARK: - Memo
                        VStack(alignment: .leading, spacing: 10) {
                            fieldTitle("メモ")

                            TextEditor(text: $memo)
                                .font(AppFonts.body)
                                .scrollContentBackground(.hidden)
                                .padding(8)
                                .frame(height: 115)
                                .background(Color(.systemGray6))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 4)
                                )
                        }
                        .padding(.vertical, 14)
                    }
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(
                                Color(.main),
                                lineWidth: 1
                            )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 16)
            }
            .scrollDismissesKeyboard(.interactively)

            // MARK: - Save Button
            Button {
                saveRule()
            } label: {
                Text(
                    editingRule == nil
                        ? "追加"
                        : "変更を保存"
                )
                .font(AppFonts.buttonText)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color(.mainButton))
                .clipShape(
                    RoundedRectangle(cornerRadius: 4)
                )
            }
            .disabled(
                ruleName.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty || minutes < 0
            )
            .opacity(
                ruleName.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty || minutes < 0 ? 0.5 : 1
            )
            .padding(.horizontal, 10)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .onAppear {
            loadRule()
        }
    }

    // MARK: - Field Title
    private func fieldTitle(_ title: String) -> some View {
        Text(title)
            .font(AppFonts.subheading)
            .foregroundStyle(.black)
    }

    // MARK: - Add Keyword
    private func addKeyword() {
        let keyword = keywordInput.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !keyword.isEmpty else {
            return
        }

        guard !keywords.contains(keyword) else {
            keywordInput = ""
            return
        }

        keywords.append(keyword)
        keywordInput = ""
    }

    // MARK: - Load Rule
    private func loadRule() {
        guard let rule = editingRule else {
            return
        }

        // MARK: - Title
        ruleName = rule.name

        // MARK: - Rule Type
        selectedType = rule.type == "arrival_buffer"
            ? .arrival
            : .notification

        // MARK: - Minutes
        minutes = rule.type == "arrival_buffer"
            ? (rule.action.minutes ?? 0)
            : (rule.action.minutesBefore ?? 0)

        // MARK: - Keywords
        keywords = rule.condition.keywords ?? []
        keywordInput = ""

        // MARK: - Memo
        memo = rule.memo ?? ""

        // MARK: - Place
        switch rule.condition.placeId {
        case "pl_home":
            selectedPlace = "自宅"

        case "pl_school":
            selectedPlace = "学校"

        case "pl_work":
            selectedPlace = "職場"

        default:
            selectedPlace = "指定なし"
        }
    }

    // MARK: - Save Rule
    private func saveRule() {
        let name = ruleName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !name.isEmpty, minutes >= 0 else {
            return
        }

        // MARK: - Keywords
        var savedKeywords = keywords

        let remainingKeyword = keywordInput.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if !remainingKeyword.isEmpty,
           !savedKeywords.contains(remainingKeyword) {
            savedKeywords.append(remainingKeyword)
        }

        // MARK: - Place
        let placeId: String?

        switch selectedPlace {
        case "自宅":
            placeId = "pl_home"

        case "学校":
            placeId = "pl_school"

        case "職場":
            placeId = "pl_work"

        default:
            placeId = nil
        }

        // MARK: - Memo
        let trimmedMemo = memo.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // MARK: - Create Rule
        let rule = UserRule(
            id: editingRule?.id ?? UUID().uuidString,
            name: name,
            memo: trimmedMemo.isEmpty ? nil : trimmedMemo,
            type: selectedType == .notification
                ? "departure_notification"
                : "arrival_buffer",
            enabled: editingRule?.enabled ?? true,
            condition: RuleCondition(
                placeId: placeId,
                keywords: savedKeywords.isEmpty
                    ? nil
                    : savedKeywords
            ),
            action: RuleAction(
                minutes: selectedType == .arrival
                    ? minutes
                    : nil,
                minutesBefore: selectedType == .notification
                    ? minutes
                    : nil
            )
        )

        // MARK: - Save
        onSave(rule)
        dismiss()
    }
}

// MARK: - Flow Layout
private struct FlowLayout: Layout {

    // MARK: - Properties
    var spacing: CGFloat = 6

    // MARK: - Size That Fits
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let width = proposal.width ?? 300
        let result = arrange(subviews, width: width)
        return result.size
    }

    // MARK: - Place Subviews
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let result = arrange(
            subviews,
            width: bounds.width
        )

        for (index, point) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(
                    x: bounds.minX + point.x,
                    y: bounds.minY + point.y
                ),
                proposal: .unspecified
            )
        }
    }

    // MARK: - Arrange
    private func arrange(
        _ subviews: Subviews,
        width: CGFloat
    ) -> (size: CGSize, positions: [CGPoint]) {
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if x > 0 && x + size.width > width {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }

            positions.append(
                CGPoint(x: x, y: y)
            )

            x += size.width + spacing
            rowHeight = max(
                rowHeight,
                size.height
            )
        }

        return (
            CGSize(
                width: width,
                height: y + rowHeight
            ),
            positions
        )
    }
}

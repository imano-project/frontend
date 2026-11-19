//
//  AddScheduleStep.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//

import SwiftUI

// MARK: - Add Schedule Step
enum AddScheduleStep {
    case suggestion
    case detail
}

// MARK: - Add Schedule View
struct AddScheduleView: View {

    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep: AddScheduleStep = .suggestion

    @State private var title = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3600)
    @State private var place = ""
    @State private var memo = ""
    @State private var isExternalCalendarEnabled = false

    @State private var isShowingConfirmation = false

    // MARK: - Category
    private var category: ScheduleCategory {
        ScheduleCategory.detect(from: title)
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Header
            HStack(spacing: 14) {

                Image(systemName: category.iconName)
                    .font(.system(size: 26))
                    .foregroundStyle(category.color)
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())

                TextField("タイトル", text: $title)
                    .font(AppFonts.title)
                    .padding(.horizontal, 16)
                    .frame(height: 60)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)

            // MARK: - Content
            Group {
                switch currentStep {

                case .suggestion:
                    AddScheduleSuggestionView(
                        title: $title,
                        startDate: $startDate,
                        endDate: $endDate
                    )

                case .detail:
                    AddScheduleDetailView(
                        startDate: $startDate,
                        endDate: $endDate,
                        place: $place,
                        memo: $memo,
                        isExternalCalendarEnabled:
                            $isExternalCalendarEnabled
                    )
                }
            }

            Spacer(minLength: 0)

            // MARK: - Footer
            HStack(spacing: 16) {

                if currentStep == .detail {
                    Button("戻る") {
                        currentStep = .suggestion
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(Color.text)
                    .background(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                }

                Button {
                    switch currentStep {

                    case .suggestion:
                        currentStep = .detail

                    case .detail:
                        isShowingConfirmation = true
                    }
                } label: {
                    Text(
                        currentStep == .suggestion
                        ? "次へ"
                        : "追加"
                    )
                    .font(AppFonts.buttonText)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(.mainButton))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                }
                .disabled(
                    title.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .background(Color(.background))
        .confirmationDialog(
            "この予定を追加しますか？",
            isPresented: $isShowingConfirmation
        ) {
            Button("追加する") {
                // TODO: 予定の保存処理
                dismiss()
            }

            Button("キャンセル", role: .cancel) {}
        } message: {
            Text(title)
        }
    }
}

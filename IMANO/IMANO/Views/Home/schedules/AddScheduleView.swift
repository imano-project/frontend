//
//  AddScheduleView.swift
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

    var onAdd: (ScheduleDisplayItem) -> Void = { _ in }
    var initialStartDate: Date? = nil
    var initialEndDate: Date? = nil

    @State private var currentStep: AddScheduleStep = .suggestion

    @State private var title = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3600)
    @State private var place = ""
    @State private var memo = ""
    @State private var isExternalCalendarEnabled = false

    // MARK: - Category
    private var category: ScheduleCategory {
        ScheduleCategory.detect(from: title)
    }

    // MARK: - Validation
    private var isValidSchedule: Bool {
        !title.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty && endDate > startDate
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
                    .font(AppFonts.buttonText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(Color.text)
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
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
                        addSchedule()
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
                    currentStep == .suggestion
                    ? title.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                    : !isValidSchedule
                )
                .opacity(
                    currentStep == .detail && !isValidSchedule
                    ? 0.5
                    : 1
                )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .background(Color(.background))
        .onAppear {
            if let initialStartDate {
                startDate = initialStartDate
            }

            if let initialEndDate {
                endDate = initialEndDate
            }
        }
    }

    // MARK: - Add Schedule
    private func addSchedule() {
        guard isValidSchedule else { return }

        let newSchedule = ScheduleDisplayItem(
            id: UUID().uuidString,
            title: title.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            startDate: startDate,
            endDate: endDate,
            place: place,
            type: "登録予定",
            memo: memo,
            size: .small
        )

        onAdd(newSchedule)
        dismiss()
    }
}

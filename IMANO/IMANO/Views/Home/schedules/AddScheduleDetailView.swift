//
//  AddScheduleDetailView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/19.
//

import SwiftUI

// MARK: - Add Schedule Detail View
struct AddScheduleDetailView: View {

    // MARK: - Properties
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var place: String
    @Binding var memo: String
    @Binding var isExternalCalendarEnabled: Bool

    @State private var isShowingLocationOptions = false

    private let durations: [(String, Int)] = [
        ("10分", 10),
        ("15分", 15),
        ("30分", 30),
        ("1時間", 60),
        ("1.5時間", 90),
        ("2時間", 120)
    ]

    private let savedLocations = [
        "自宅",
        "学校",
        "職場"
    ]

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: - Date & Time
                VStack(alignment: .leading, spacing: 16) {
                    Text("日時")
                        .font(AppFonts.subheading)
                        .foregroundStyle(Color.text)

                    // MARK: - Date
                    VStack(alignment: .leading, spacing: 8) {
                        Text("日付")
                            .font(AppFonts.body)

                        DatePicker(
                            "日付",
                            selection: $startDate,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .tint(Color(.mainButton))
                    }

                    // MARK: - Time
                    VStack(alignment: .leading, spacing: 12) {
                        Text("時間")
                            .font(AppFonts.body)

                        HStack(spacing: 12) {

                            DatePicker(
                                "開始",
                                selection: $startDate,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()

                            Text("〜")
                                .foregroundStyle(Color.text)

                            DatePicker(
                                "終了",
                                selection: $endDate,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                        }
                        .datePickerStyle(.compact)
                        .tint(Color(.mainButton))

                        // MARK: - Duration Buttons
                        HStack(spacing: 6) {
                            ForEach(durations, id: \.1) { duration in
                                Button {
                                    setDuration(duration.1)
                                } label: {
                                    Text(duration.0)
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color.text)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 8)
                                        .background(
                                            Color.gray.opacity(0.12)
                                        )
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 5)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }

                Divider()

                // MARK: - Location
                VStack(alignment: .leading, spacing: 12) {
                    Text("場所")
                        .font(AppFonts.subheading)
                        .foregroundStyle(Color.text)

                    Button {
                        isShowingLocationOptions = true
                    } label: {
                        HStack {
                            Text(
                                place.isEmpty
                                ? "登録している住所から選択"
                                : place
                            )
                            .foregroundStyle(
                                place.isEmpty ? .gray : Color.text
                            )

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .font(AppFonts.body)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 6)
                        )
                    }
                    .buttonStyle(.plain)

                    TextField("住所・場所を入力", text: $place)
                        .font(AppFonts.body)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 6)
                        )
                }

                Divider()

                // MARK: - Memo
                VStack(alignment: .leading, spacing: 12) {
                    Text("メモ")
                        .font(AppFonts.subheading)
                        .foregroundStyle(Color.text)

                    TextEditor(text: $memo)
                        .font(AppFonts.body)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .frame(height: 130)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 6)
                        )
                }

                Divider()

                // MARK: - External Calendar
                Toggle(
                    "外部カレンダーに登録する",
                    isOn: $isExternalCalendarEnabled
                )
                .font(AppFonts.body)
                .tint(Color(.mainButton))
            }
            .padding(16)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        Color(.mainButton),
                        lineWidth: 1
                    )
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .confirmationDialog(
            "場所を選択",
            isPresented: $isShowingLocationOptions
        ) {
            ForEach(savedLocations, id: \.self) { location in
                Button(location) {
                    place = location
                }
            }

            Button("キャンセル", role: .cancel) {}
        }
    }

    // MARK: - Set Duration
    private func setDuration(_ minutes: Int) {
        endDate = Calendar.current.date(
            byAdding: .minute,
            value: minutes,
            to: startDate
        ) ?? startDate
    }
}

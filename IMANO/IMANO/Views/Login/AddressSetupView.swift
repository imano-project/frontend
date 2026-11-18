//
//  AddressSetupView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/12.
//

import SwiftUI

// MARK: - Address Form Item
struct AddressFormItem: Identifiable {
    let id = UUID()
    var title: String
    var address: String = ""
    var isCustom: Bool = false

}

// MARK: - Address Setup View
struct AddressSetupView: View {

    // MARK: - Properties
    var onNext: (String, [AddressFormItem]) -> Void
    var onSkip: () -> Void
    @State private var homeAddress = ""
    @State private var additionalAddresses = [
        AddressFormItem(title: "学校"),
        AddressFormItem(title: "職場")
    ]

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Progress Indicator
            SetupProgressBar(currentStep: 1)
                .padding(.top, 30)

            // MARK: - Title
            VStack(spacing: 12) {
                Text("住所登録")
                    .font(AppFonts.heading)
                    .foregroundStyle(Color.text)
                Text("よく利用する場所を登録すると、\n場所に合わせた情報を表示できます。")
                    .font(AppFonts.sentence)
                    .foregroundStyle(Color.text)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 25)
            .padding(.top, 45)

            // MARK: - Address List
            ScrollView {
                VStack(spacing: 25) {
                    addressField(
                        title: "自宅",
                        address: $homeAddress
                    )
                    ForEach($additionalAddresses) { $item in
                        addressField(
                            title: item.title,
                            address: $item.address,
                            canDelete: true,
                            titleBinding: item.isCustom
                                ? $item.title
                                : nil,
                            onDelete: {
                                additionalAddresses.removeAll {
                                    $0.id == item.id
                                }
                            }
                        )
                    }
                    Button {
                        additionalAddresses.append(
                            AddressFormItem(
                                title: "",
                                isCustom: true
                            )
                        )
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 34, weight: .regular))
                            .foregroundStyle(Color.text)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.main, lineWidth: 2)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 40)
            .padding(.top, 20)
            .frame(maxHeight: .infinity)
            Spacer(minLength: 20)

            // MARK: - Action Buttons
            VStack(spacing: 20) {
                Button {
                    onSkip()
                } label: {
                    Text("スキップ")
                        .font(AppFonts.blackButtonText)
                        .foregroundStyle(Color.text)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.text, lineWidth: 1)
                        }
                }
                Button {
                    onNext(homeAddress, additionalAddresses)
                } label: {
                    Text("次へ")
                        .font(AppFonts.buttonText)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            Color.mainButton,
                            in: RoundedRectangle(cornerRadius: 6)
                        )
                }
                .disabled(
                    homeAddress.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
                .opacity(
                    homeAddress.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                    ? 0.5 : 1
                )
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.background)
                .ignoresSafeArea()
        }
    }

    // MARK: - Address Field
    private func addressField(
        title: String,
        address: Binding<String>,
        canDelete: Bool = false,
        titleBinding: Binding<String>? = nil,
        onDelete: (() -> Void)? = nil
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if let titleBinding {
                    TextField(
                        "場所の名前を入力",
                        text: titleBinding
                    )
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
                } else {
                    Text(title)
                        .font(AppFonts.body)
                        .foregroundStyle(Color.text)
                }
                Spacer()
                if canDelete {
                    Button {
                        onDelete?()
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.text)
                            .frame(width: 24, height: 30)
                    }
                }
            }
            TextField("住所入力", text: address)
                .font(AppFonts.body)
                .padding(.horizontal, 12)
                .frame(height: 42)
                .background(Color.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

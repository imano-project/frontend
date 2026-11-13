//
//  AddressFormItem.swift
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
            HStack(spacing: 5) {
                ForEach(0..<4, id: \.self) { index in
                    Capsule()
                        .fill(index == 0 ? Color.main : Color.gray.opacity(0.15))
                        .frame(height: 10)
                }
            }
            .padding(.horizontal, 50)
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
                    // Home Address
                    addressField(
                        title: "自宅",
                        address: $homeAddress
                    )
                    // Additional Addresses
                    ForEach($additionalAddresses) { $item in
                        addressField(
                            title: item.title,
                            address: $item.address,
                            canDelete: true,
                            onDelete: {
                                additionalAddresses.removeAll {
                                    $0.id == item.id
                                }
                            }
                        )
                    }
                    // Add Address Button
                    Button {
                        additionalAddresses.append(
                            AddressFormItem(title: "その他")
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
                // Skip Button
                Button {
                    onSkip()
                } label: {
                    Text("スキップ")
                        .font(AppFonts.body)
                        .foregroundStyle(Color.text)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.text, lineWidth: 1)
                        }
                }
                // Next Button
                Button {
                    onNext(homeAddress, additionalAddresses)
                } label: {
                    Text("次へ")
                        .font(AppFonts.body)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(
                            Color(.mainButton),
                            in: RoundedRectangle(cornerRadius: 6)
                        )
                }
                .disabled(
                    homeAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
                .opacity(
                    homeAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    ? 0.5 : 1
                )
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background))
    }

    // MARK: - Address Field
    private func addressField(
        title: String,
        address: Binding<String>,
        canDelete: Bool = false,
        onDelete: (() -> Void)? = nil
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title and Delete Button
            HStack {
                Text(title)
                    .font(AppFonts.body)
                    .foregroundStyle(Color.text)
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
            // Address TextField
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

// MARK: - Preview
#Preview {
    AddressSetupView(
        onNext: { homeAddress, additionalAddresses in },
        onSkip: {}
    )
}

//
//  RuleSearchView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/10.
//


import SwiftUI

// MARK: - Rule Search View
struct RuleSearchView: View {

    // MARK: - Properties
    @Binding var searchText: String

    // MARK: - Body
    var body: some View {
        TextField("検索", text: $searchText)
            .font(.system(size: 16))
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}


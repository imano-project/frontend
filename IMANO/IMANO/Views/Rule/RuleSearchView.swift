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
            .padding(.horizontal, 18)
            .frame(height: 50)
            .background(Color(.gray))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

//
//  HomeView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/28.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    @StateObject private var dateViewModel = DateViewModel()

    // MARK: - body
    var body: some View {
        VStack {
            Text(dateViewModel.dateText)
            Text(dateViewModel.timeText)
        }
    }
}

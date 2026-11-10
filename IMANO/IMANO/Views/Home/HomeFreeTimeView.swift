//
//  HomeFreeTimeView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/10.
//

import SwiftUI

struct HomeFreeTimeView: View {

    // MARK: - Properties
    @Binding var isShowingFreeTime: Bool

    // MARK: - Body
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isShowingFreeTime.toggle()
            }
        } label: {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(
                            isShowingFreeTime
                            ? Color(.mainButton)
                            : Color(.gray)
                        )
                    Text("空き時間")
                        .font(AppFonts.sentence)
                        .foregroundStyle(
                            isShowingFreeTime
                            ? Color(.white)
                            : Color(red: 0.694, green: 0.694, blue: 0.694)
                        )
                        .lineLimit(1)
                        .fixedSize()
                        .frame(
                            width: geometry.size.width - 48,
                            alignment: isShowingFreeTime ? .leading : .trailing
                        )
                        .offset(x: isShowingFreeTime ? 5 : 43)
                    Circle()
                        .fill(.white)
                        .frame(width: 16.46, height: 16.46)
                        .shadow(color: .black.opacity(0.12), radius: 2)
                        .offset(
                            x: isShowingFreeTime
                            ? geometry.size.width - 20
                            : 3
                        )
                }
            }
            .frame(width: 75, height: 20)
        }
        .buttonStyle(.plain)
    }
}

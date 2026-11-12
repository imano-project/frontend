//
//  RootView.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/12.
//



import SwiftUI

struct RootView: View {

    // MARK: - Screen

    private enum Screen {
        case login
        case permission
        case address
        case calendar
        case widget
        case main
    }

    // MARK: - Properties

    @State private var currentScreen: Screen = .login

    @State private var homeAddress = ""
    @State private var additionalAddresses: [AddressFormItem] = []

    // MARK: - Body

    var body: some View {
        Group {
            switch currentScreen {

            // MARK: - Login

            case .login:
                LoginView {
                    currentScreen = .permission
                }

            // MARK: - Permission

            case .permission:
                SetupView(
                    onNext: {
                        currentScreen = .address
                    }
                )

            // MARK: - Address

            case .address:
                AddressSetupView(
                    onNext: { home, addresses in
                        homeAddress = home
                        additionalAddresses = addresses
                        currentScreen = .calendar
                    },
                    onSkip: {
                        currentScreen = .calendar
                    }
                )

            // MARK: - Calendar

            case .calendar:
                CalendarSetupView(
                    onNext: {
                        currentScreen = .widget
                    },
                    onSkip: {
                        currentScreen = .widget
                    },
                    onGoogleConnect: {
                        // Google連携処理は後で実装
                    }
                )

            // MARK: - Widget

            case .widget:
                WidgetSetupView(
                    onNext: {
                        currentScreen = .main
                    },
                    onSkip: {
                        currentScreen = .main
                    }
                )

            // MARK: - Main

            case .main:
                MainTabView()
            }
        }
    }
}

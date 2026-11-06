//
//  MovementState.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/02.
//

import CoreMotion

enum MovementState {
    case stationary
    case walking
    case running
    case cycling
    case automotive
    case unknown

    // MARK: - Initializer
    init(activity: CMMotionActivity) {
        if activity.stationary {
            self = .stationary
        } else if activity.walking {
            self = .walking
        } else if activity.running {
            self = .running
        } else if activity.cycling {
            self = .cycling
        } else if activity.automotive {
            self = .automotive
        } else {
            self = .unknown
        }
    }

    // MARK: - Properties
    var isMoving: Bool {
        switch self {
        case .walking, .running, .cycling, .automotive:
            return true
        case .stationary, .unknown:
            return false
        }
    }
}

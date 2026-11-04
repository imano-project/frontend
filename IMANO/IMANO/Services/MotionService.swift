//
//  MotionService.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/11/02.
//

import CoreMotion

final class MotionService {
    
    // MARK: - Properties
    var onActivityUpdate: ((MovementState) -> Void)?
    private let activityManager = CMMotionActivityManager()
    
    // MARK: - Methods
    func startMonitoring() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            return
        }
        activityManager.startActivityUpdates(to: .main) { [weak self] activity in
            guard let activity else {
                return
            }
            let state = MovementState(activity: activity)
            self?.onActivityUpdate?(state)
        }
    }
    
    func stopMonitoring() {
        activityManager.stopActivityUpdates()
    }
}

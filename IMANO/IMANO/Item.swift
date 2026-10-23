//
//  Item.swift
//  IMANO
//
//  Created by 川岸遥奈 on 2026/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

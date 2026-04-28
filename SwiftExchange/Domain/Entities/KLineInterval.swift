//
//  KLineInterval.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

enum KLineInterval: String, CaseIterable, Sendable {
    case oneMinute = "1m"
    case fiveMinutes = "5m"
    case fifteenMinutes = "15m"
    case oneHour = "1h"
    case oneDay = "1d"

    var title: String {
        switch self {
        case .oneMinute:
            return "1m"
        case .fiveMinutes:
            return "5m"
        case .fifteenMinutes:
            return "15m"
        case .oneHour:
            return "1h"
        case .oneDay:
            return "1d"
        }
    }
}

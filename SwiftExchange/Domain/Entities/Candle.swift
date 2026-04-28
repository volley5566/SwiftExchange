//
//  Candle.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import Foundation

/**
 open  开盘价
 high  最高价
 low   最低价
 close 收盘价
 volume 成交量
 **/

struct Candle: Identifiable, Equatable, Sendable {
    let id: UUID
    let openTime: Date
    let open: Decimal
    let high: Decimal
    let low: Decimal
    let close: Decimal
    let volume: Decimal

    init(
        id: UUID = UUID(),
        openTime: Date,
        open: Decimal,
        high: Decimal,
        low: Decimal,
        close: Decimal,
        volume: Decimal
    ) {
        self.id = id
        self.openTime = openTime
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
    }

    var isBullish: Bool {
        close >= open
    }
}

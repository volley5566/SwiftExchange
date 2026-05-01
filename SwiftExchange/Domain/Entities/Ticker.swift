//
//  Ticker.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import Foundation

/**
 自动收报机
 Identifiable 是为了 SwiftUI 的 List / ForEach 能识别每个元素。
 Equatable 方便比较状态，也方便测试。
 Sendable 表示这个模型可以安全地跨并发上下文传递。这在行情流、高并发场景里是一个好习惯。
 **/
struct Ticker: Identifiable, Equatable, Sendable {
    var id: String { symbol }

    let symbol: String
    let baseAsset: String
    let quoteAsset: String
    let lastPrice: Decimal
    let changePercent: Decimal
    let volume: Decimal
}

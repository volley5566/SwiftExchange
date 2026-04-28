//
//  MarketRepository.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import Foundation

protocol MarketRepository: Sendable {
    func getTickers() async throws -> [Ticker]

    func getCandles(
        symbol: String,
        interval: KLineInterval
    ) async throws -> [Candle]

    func observeTicker(
        symbol: String
    ) -> AsyncThrowingStream<Ticker, Error>
}

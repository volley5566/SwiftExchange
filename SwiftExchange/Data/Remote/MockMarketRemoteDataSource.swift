//
//  MockMarketRemoteDataSource.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import Foundation
/**
 AsyncThrowingStream 它可以模拟 WebSocket 行情流
 真实交易所一般不是每次都 HTTP 拉行情，而是：
 HTTP / GraphQL Query：拉初始数据
 WebSocket / GraphQL Subscription：订阅实时行情
 我们现在 mock 的 observeTicker，以后可以直接换成真实 WebSocket 或 GraphQL Subscription。
 **/
protocol MarketRemoteDataSource: Sendable {
    func fetchTickers() async throws -> [Ticker]
    func fetchCandles(symbol: String, interval: KLineInterval) async throws -> [Candle]
    func observeTicker(symbol: String) -> AsyncThrowingStream<Ticker, Error>
}

final class MockMarketRemoteDataSource: MarketRemoteDataSource, @unchecked Sendable {

    func fetchTickers() async throws -> [Ticker] {
        try await Task.sleep(nanoseconds: 500_000_000)

        return [
            Ticker(
                symbol: "BTCUSDT",
                baseAsset: "BTC",
                quoteAsset: "USDT",
                lastPrice: Decimal(64200.12),
                changePercent: Decimal(2.31),
                volume: Decimal(98234.45)
            ),
            Ticker(
                symbol: "ETHUSDT",
                baseAsset: "ETH",
                quoteAsset: "USDT",
                lastPrice: Decimal(3180.55),
                changePercent: Decimal(-1.12),
                volume: Decimal(76231.00)
            ),
            Ticker(
                symbol: "SOLUSDT",
                baseAsset: "SOL",
                quoteAsset: "USDT",
                lastPrice: Decimal(146.80),
                changePercent: Decimal(5.24),
                volume: Decimal(45123.78)
            )
        ]
    }

    func fetchCandles(
        symbol: String,
        interval: KLineInterval
    ) async throws -> [Candle] {
        try await Task.sleep(nanoseconds: 400_000_000)

        let now = Date()
        var candles: [Candle] = []
        var price = Double.random(in: 50_000...70_000)

        for index in 0..<120 {
            let open = price
            let close = open + Double.random(in: -800...800)
            let high = max(open, close) + Double.random(in: 50...400)
            let low = min(open, close) - Double.random(in: 50...400)
            let volume = Double.random(in: 100...2000)

            let candle = Candle(
                openTime: Calendar.current.date(
                    byAdding: .minute,
                    value: -120 + index,
                    to: now
                ) ?? now,
                open: Decimal(open),
                high: Decimal(high),
                low: Decimal(low),
                close: Decimal(close),
                volume: Decimal(volume)
            )

            candles.append(candle)
            price = close
        }

        return candles
    }

    func observeTicker(
        symbol: String
    ) -> AsyncThrowingStream<Ticker, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                var price = Double.random(in: 50_000...70_000)

                while !Task.isCancelled {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)

                    price += Double.random(in: -100...100)

                    let ticker = Ticker(
                        symbol: symbol,
                        baseAsset: symbol.replacingOccurrences(of: "USDT", with: ""),
                        quoteAsset: "USDT",
                        lastPrice: Decimal(price),
                        changePercent: Decimal(Double.random(in: -5...5)),
                        volume: Decimal(Double.random(in: 10_000...100_000))
                    )

                    continuation.yield(ticker)
                }
            }

            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}

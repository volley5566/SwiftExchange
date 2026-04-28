//
//  GetCandlesUseCase.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

struct GetCandlesUseCase: Sendable {
    private let repository: MarketRepository

    init(repository: MarketRepository) {
        self.repository = repository
    }

    func execute(
        symbol: String,
        interval: KLineInterval
    ) async throws -> [Candle] {
        try await repository.getCandles(
            symbol: symbol,
            interval: interval
        )
    }
}

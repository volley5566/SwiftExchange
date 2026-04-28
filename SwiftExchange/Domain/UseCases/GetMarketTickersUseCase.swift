//
//  GetMarketTickersUseCase.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

struct GetMarketTickersUseCase: Sendable {
    private let repository: MarketRepository

    init(repository: MarketRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Ticker] {
        try await repository.getTickers()
    }
}

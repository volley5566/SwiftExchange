//
//  ObserveTickerUseCase.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

struct ObserveTickerUseCase: Sendable {
    private let repository: MarketRepository

    init(repository: MarketRepository) {
        self.repository = repository
    }

    func execute(symbol: String) -> AsyncThrowingStream<Ticker, Error> {
        repository.observeTicker(symbol: symbol)
    }
}

//
//  DefaultMarketRepository.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//


/**
 View
  -> Store
  -> UseCase
  -> Repository Protocol
  -> DefaultMarketRepository
  -> MockMarketRemoteDataSource
 
 以后换真实接口时，变成
 View
  -> Store
  -> UseCase
  -> Repository Protocol
  -> DefaultMarketRepository
  -> GraphQLMarketRemoteDataSource
 
 上层完全不用动。
 这就是架构的价值。
 **/
final class DefaultMarketRepository: MarketRepository, @unchecked Sendable {
    private let remoteDataSource: MarketRemoteDataSource

    init(remoteDataSource: MarketRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getTickers() async throws -> [Ticker] {
        try await remoteDataSource.fetchTickers()
    }

    func getCandles(
        symbol: String,
        interval: KLineInterval
    ) async throws -> [Candle] {
        try await remoteDataSource.fetchCandles(
            symbol: symbol,
            interval: interval
        )
    }

    func observeTicker(
        symbol: String
    ) -> AsyncThrowingStream<Ticker, Error> {
        remoteDataSource.observeTicker(symbol: symbol)
    }
}

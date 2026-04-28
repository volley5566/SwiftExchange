//
//  MarketListState.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

struct MarketListState {
    var isLoading: Bool = false
    var tickers: [Ticker] = []
    var errorMessage: String?
}

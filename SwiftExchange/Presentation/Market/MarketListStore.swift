//
//  MarketListStore.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import Foundation
import Combine
/**
 Foundation = 基础工具，比如 Date、Decimal、Error、UUID
 Combine = 响应式状态能力，比如 ObservableObject、@Published
 SwiftUI = UI 框架，比如 View、Text、List、@StateObject
 **/

@MainActor
final class MarketListStore: ObservableObject {
    @Published private(set) var state = MarketListState()

    private let getMarketTickersUseCase: GetMarketTickersUseCase

    init(getMarketTickersUseCase: GetMarketTickersUseCase) {
        self.getMarketTickersUseCase = getMarketTickersUseCase
    }

    func send(_ intent: MarketListIntent) {
        switch intent {
        case .onAppear:
            Task {
                await loadTickers()
            }

        case .refresh:
            Task {
                await loadTickers()
            }
        }
    }

    private func loadTickers() async {
        state.isLoading = true
        state.errorMessage = nil

        do {
            let tickers = try await getMarketTickersUseCase.execute()
            state.tickers = tickers
        } catch {
            state.errorMessage = error.localizedDescription
        }

        state.isLoading = false
    }
}

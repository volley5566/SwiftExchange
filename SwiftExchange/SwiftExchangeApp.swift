//
//  SwiftExchangeApp.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import SwiftUI

@main
struct SwiftExchangeApp: App {
    private let environment = AppEnvironment.mock()

    var body: some Scene {
        WindowGroup {
            MarketListView(
                store: MarketListStore(
                    getMarketTickersUseCase: GetMarketTickersUseCase(
                        repository: environment.marketRepository
                    )
                )
            )
        }
    }
}

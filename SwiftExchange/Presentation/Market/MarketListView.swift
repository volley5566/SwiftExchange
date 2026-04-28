//
//  MarketListView.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import SwiftUI

struct MarketListView: View {
    @StateObject private var store: MarketListStore

    init(store: MarketListStore) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Markets")
                .task {
                    store.send(.onAppear)
                }
                .refreshable {
                    store.send(.refresh)
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if store.state.isLoading {
            ProgressView("Loading markets...")
        } else if let errorMessage = store.state.errorMessage {
            VStack(spacing: 12) {
                Text("加载失败")
                    .font(.headline)

                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Button("重试") {
                    store.send(.refresh)
                }
            }
        } else {
            List(store.state.tickers) { ticker in
                NavigationLink {
                    Text("KLine Detail: \(ticker.symbol)")
                } label: {
                    MarketTickerRow(ticker: ticker)
                }
            }
        }
    }
}

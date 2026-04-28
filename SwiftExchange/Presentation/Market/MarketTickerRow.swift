//
//  MarketTickerRow.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

import SwiftUI

struct MarketTickerRow: View {
    let ticker: Ticker

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(ticker.baseAsset)
                    .font(.headline)

                Text(ticker.symbol)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(formatDecimal(ticker.lastPrice))
                    .font(.headline)
                    .monospacedDigit()

                Text(formatPercent(ticker.changePercent))
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(ticker.changePercent >= 0 ? .green.opacity(0.15) : .red.opacity(0.15))
                    .foregroundStyle(ticker.changePercent >= 0 ? .green : .red)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.vertical, 6)
    }

    private func formatDecimal(_ value: Decimal) -> String {
        let number = NSDecimalNumber(decimal: value)
        return String(format: "%.2f", number.doubleValue)
    }

    private func formatPercent(_ value: Decimal) -> String {
        let number = NSDecimalNumber(decimal: value)
        return String(format: "%+.2f%%", number.doubleValue)
    }
}

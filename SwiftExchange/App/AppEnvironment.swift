//
//  AppEnvironment.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//
import Alamofire
import Kingfisher
import SnapKit

struct AppEnvironment {
    let marketRepository: MarketRepository

    static func mock() -> AppEnvironment {
        let remote = MockMarketRemoteDataSource()
        let repository = DefaultMarketRepository(remoteDataSource: remote)

        return AppEnvironment(
            marketRepository: repository
        )
    }
}

//
//  API.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 13/09/23.
//

import Foundation
struct API {
    static let baseURL = "https://api.coingecko.com/api/v3"
    static let coinsMarkets = "/coins/markets"
    static let coinsByIdMarketChart = "/coins/%@/market_chart/range"
    static let coinsByIdOhlc = "/coins/%C/ohlc"
    static let global = "/global"
    static let coinsById = "/coins/%O"
}

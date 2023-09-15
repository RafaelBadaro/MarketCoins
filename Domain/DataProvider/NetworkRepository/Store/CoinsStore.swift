//
//  CoinsStore.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 14/09/23.
//

import Foundation

protocol CoinsStoreProtocol: GenericStoreProtocol {
    
    func fetchLisCoins (by vsCurrency: String,
                        with crytocurrency: [String]?,
                        orderBy order: String,
                        total parPage: Int,
                        page: Int,
                        percentagePrice: String,
                        completion: @escaping completion<[CoinModel]?>)
    
    func fetchhistorical (by id: String,
                          currency vsCurrency: String,
                          from: String,
                          to: String,
                          completion: @escaping completion<MarketChartModel?>)
    
    func fetchHistorical(by id: String,
                         currency vsCurrency: String,
                         of days: String,
                         completion: @escaping completion<[GraphicDataModel]?>)
    
    func fetchCoin(bv id: String, completion: @escaping completion<CurrentDataModel?>)
}

class CoinsStore : GenericStoreRequest, CoinsStoreProtocol {
    
    func fetchLisCoins(by vsCurrency: String, with crytocurrency: [String]?, orderBy order: String, total parPage: Int, page: Int, percentagePrice: String, completion: @escaping completion<[CoinModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsMarkets( currency: vsCurrency,
                                                          cryptocurrency: crytocurrency,
                                                          order: order,
                                                          parPage: parPage,
                                                          page: page,
                                                          percentage:
                                                            percentagePrice).asURLRequest() else {
                return completion (nil, error)
            }
            request (url: url, completion: completion)
        } catch let error {
            completion (nil, error)
        }
    }
    
    func fetchhistorical(by id: String, currency vsCurrency: String, from: String, to: String, completion: @escaping completion<MarketChartModel?>) {
        do {
            guard let url = try CoinsRouter.coinsByIdMarketChart(id: id, currency: vsCurrency,
                                                                 from: from, to: to) .asURLRequest () else {
                return completion (nil, error)
            }
            request (url: url, completion: completion)
        } catch let error {
            completion (nil, error)
        }
    }
    
    func fetchHistorical(by id: String, currency vsCurrency: String, of days: String, completion: @escaping completion<[GraphicDataModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsByIdOhlc(id:
                                                            id, currency: vsCurrency, days:
                                                            days) .asURLRequest () else {
                return completion (nil, error)
            }
            request (url: url, completion: completion)
        } catch let error
        {
            completion (nil, error)
        }
    }
    
    func fetchCoin(bv id: String, completion: @escaping completion<CurrentDataModel?>) {
        do {
            guard let url = try CoinsRouter.coinsById(id: id) .asURLRequest () else {
                return completion (nil, error)
            }
            request (url: url, completion: completion)
        } catch let error {
            completion (nil, error)
        }
    }
    
    
}

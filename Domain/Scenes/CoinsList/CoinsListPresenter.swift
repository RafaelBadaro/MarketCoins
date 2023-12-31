//
//  CoinsListPresenter.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 14/09/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinsListPresentationLogic
{
    func presentGlobalValues(response: CoinsList.FetchGlobalValues.Response)
    func presentErrorForGlobalValues(baseCoin: CoinsFilterEnum)
    func presentListCoins(response: [CoinsList.FetchListCoins.Reponse])
    func presentError(error: CryptocurrenciesError)
}

class CoinsListPresenter: CoinsListPresentationLogic
{
    weak var viewController: CoinsListDisplayLogic?
    
    func presentGlobalValues(response: CoinsList.FetchGlobalValues.Response) {
        var globalValues: [CoinsList.FetchGlobalValues.ViewModel.GlobalValues] = []
        
        for(_, value) in response.totalMarketCap {
            globalValues.append(
                CoinsList.FetchGlobalValues.ViewModel.GlobalValues(
                    title: "Capitalizaçao de mercado global",
                    value: value.toCurrency(from: response.baseCoin)
                )
            )
        }
        
        for (_, value) in response.totalVolume {
            globalValues.append(
                CoinsList.FetchGlobalValues.ViewModel.GlobalValues(
                    title: "Volume em 24hrs",
                    value: value.toCurrency(from: response.baseCoin)
                )
            ) 
        }
        
        let viewModel = CoinsList.FetchGlobalValues.ViewModel(
            globalValues: globalValues
        )
        
        viewController?.displayGlobalValues(viewModel: viewModel)
    }
    
    func presentErrorForGlobalValues(baseCoin: CoinsFilterEnum) {
        let globalValues: [CoinsList.FetchGlobalValues.ViewModel.GlobalValues] = [
            CoinsList.FetchGlobalValues.ViewModel.GlobalValues(
                title: "Capitalizaçao de mercado global",
                value: 0.0.toCurrency(from: baseCoin)
            ),
            CoinsList.FetchGlobalValues.ViewModel.GlobalValues(
                title: "Volume em 24hrs",
                value: 0.0.toCurrency(from: baseCoin)
            )
        ]
        
        
        let viewModel = CoinsList.FetchGlobalValues.ViewModel(
            globalValues: globalValues
        )
        
        viewController?.displayGlobalValues(viewModel: viewModel)
    }
    
    func presentListCoins(response: [CoinsList.FetchListCoins.Reponse]) {
        let coins = response.map {response in
            var rank = "-"
            
            if let marketCapRank = response.marketCapRank {
                rank = "\(marketCapRank)"
            }
            
            return CoinsList.FetchListCoins.ViewModel.Coin(
                id: response.id,
                name: response.name,
                rank: rank,
                iconUrl: response.image,
                symbol: response.symbol.uppercased(),
                price: response.currentPrice.toCurrency(from: response.baseCoin),
                priceChangePercentage: response.priceChangePercentage.toPercentage(),
                marketCapitalization: response.marketCap.toCurrency(from: response.baseCoin)
            )
        }
        
        let viewModel = CoinsList.FetchListCoins.ViewModel (
            coins: coins
        )
        
        viewController?.displayListCoins(viewModel: viewModel)
    }
    
    func presentError(error: CryptocurrenciesError) {
        viewController?.displayError(erro: error.errorDescription)
    }
}

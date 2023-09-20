//
//  CoinHeaderView.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 18/09/23.
//

import UIKit

class CoinHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CoinHeaderView"
    
    @IBOutlet weak var testFinal: UILabel!
    
    func setupPriceChangePercentage(from filter: Filter){
        if filter.type == .priceChangePercentage {
            if let priceChangePercentageFilter = PriceChangePercentageFilterEnum(rawValue: filter.key){
                testFinal.text = priceChangePercentageFilter.title
            }
        }
    }
}

//
//  CryptoCurrenciesError.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 14/09/23.
//

import Foundation

enum CryptocurrenciesError: Error {
    case internalServerError
    case badRequestError
    case notFoundError
    case undefinedError
    var errorDescription: String {
        switch self {
        case .internalServerError:
            return "Ocorreu um erro no servidor! Gostaria de tentar novamento?"
        case .badRequestError:
            return "Sua requisição não foi bem sucedida! Gostaria de tentar novamento?"
        case .notFoundError:
            return "O serviço que você está buscando não existe! Gostaria de tentar novamento?"
        case .undefinedError:
            return "Ocorreu um erro. Tente novamente mais tarde! Gostaria de tentar novamento?"
        }
    }
}

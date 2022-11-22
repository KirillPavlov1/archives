//
//  skproduct.swift
//  create archives
//
//  Created by Кирилл on 02.11.2022.
//

import Foundation
import StoreKit

extension SKProduct {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    var isFree: Bool {
        price == 0.00
    }
    
    var isTrialFree: Bool? {
        return introductoryPrice?.price == 0.00
    }

    var localizedPrice: String? {
        let formatter = SKProduct.formatter
        formatter.locale = priceLocale

        return formatter.string(from: price)
    }
    
    var localizedTrialPrice: String? {
        guard let price = introductoryPrice?.price  else {
            return nil
        }
        
        let formatter = SKProduct.formatter
        formatter.locale = priceLocale
        
        if let isFree = isTrialFree {
            return isFree ? "Free" : formatter.string(from: price)
        }
        
        return formatter.string(from: price)
    }

}

extension SKProduct.PeriodUnit {

    var description: String {
        switch self {
        case .day: return "day"
        case .week: return "week"
        case .month: return "month"
        case .year: return "year"
        default:
            return "N/A"
        }
    }

    func pluralisedDescription(length: Int?) -> String {
        guard let length = length else { return "" }
        let lengthAndDescription = length.description + " " + self.description
        let plural = length > 1 ?  lengthAndDescription + "s" : lengthAndDescription
        return plural
    }
}

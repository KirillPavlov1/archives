//
//  class observ.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import Foundation
import SwiftUI
import ApphudSDK

enum Page0{
    case onboarding
    case main
    case paywall
}

enum Page1{
    case home
    case settings
}


class router: ObservableObject{
    @Published var currentPage0: Page0 = Apphud.hasActiveSubscription() ? .main : .onboarding
    @Published var currentPage1: Page1 = .home
    private var product: ApphudProduct!
    private var title: String?
    private var subtitle: String?
    private var subunits: Int?
    var subperiod: String!
    var trialperiod: String!
    var productPrice: String!
    var trialPrice: String!
    var productCurrency: String!

    init()
    {
        configureProduct()
    }

    func configure() {
        guard let skProduct = product.skProduct else { return }
        let subUnits = skProduct.subscriptionPeriod?.numberOfUnits
        let trialUnits = skProduct.introductoryPrice?.subscriptionPeriod.numberOfUnits
        subperiod = skProduct.subscriptionPeriod?.unit.pluralisedDescription(length: subUnits)
        trialperiod = skProduct.introductoryPrice?.subscriptionPeriod.unit.pluralisedDescription(length: trialUnits)
        self.productPrice = skProduct.localizedPrice
        self.trialPrice = skProduct.localizedTrialPrice
        self.productCurrency = skProduct.priceLocale.currencyCode
    }
    
    func subscribe(){
        Apphud.purchase(product) { [self]result in
            if let subscription = result.subscription, subscription.isActive(){
                currentPage0 = .main
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive(){
                currentPage0 = .main
            } else {
            }
        }
    }

    func restore(){
        Apphud.restorePurchases{ subscriptions, purchases, error in
           if Apphud.hasActiveSubscription(){
               self.currentPage0 = .main
           } else {
           }
        }
    }
    
    var paywall: ApphudPaywall?
    var products: [ApphudProduct]?

    func configureProduct() {
        Apphud.paywallsDidLoadCallback { (paywalls) in
            if let paywall = paywalls.first(where: { $0.identifier == "paywall1" }){
                guard let product = paywall.products.first
                else {
                    return
                }
                self.product = product
                let json = paywall.json
                self.title = json?["title"] as? String
                self.subtitle = json?["subtitle"] as? String
                self.configure()
            }
        }
    }
}

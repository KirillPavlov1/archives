//
//  mother.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import Foundation
import SwiftUI

struct Mother0: View{

    @StateObject var rou: router
    
    var body: some View{
        switch rou.currentPage0 {
            case .onboarding:
                onboarding(rou: rou)
            case .main:
                Mother1(rou: rou)
            case .paywall:
                paywallView(rou: rou)
        }
    }
}

//
//  isLoading.swift
//  create archives
//
//  Created by Кирилл on 29.11.2022.
//

import Foundation
import SwiftUI

struct loadingView: View{
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .edgesIgnoringSafeArea(.all)
            Image("loading")
        }
    }
}

struct loadingViewpp: PreviewProvider {
    static var previews: some View {
        loadingView()
    }
}

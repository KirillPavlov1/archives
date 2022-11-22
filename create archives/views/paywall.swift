//
//  paywall.swift
//  create archives
//
//  Created by Кирилл on 02.11.2022.
//

import Foundation
import SwiftUI

struct paywallView:View{

    @StateObject var rou: router

    var back: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Button(action:{rou.currentPage0 = .main})
                    {
                        Image(systemName: "multiply")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, UIScreen.sW * 0.05)
                            .scaleEffect(2.5)
                    }
                }
                Spacer()
            }
            VStack{
                Image("onb4")
                    .padding(.top, UIScreen.sH * 0.1)
                Text("Get more with PRO")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.03, weight: .bold))
                    .padding(.top, UIScreen.sH * 0.02)
                    .padding(.bottom, UIScreen.sH * 0.02)
                Text("No ads, increased storage size\n and other useful features")
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.02))
                    .multilineTextAlignment(.center)
                if (rou.trialperiod != nil)
                {
                    Text("Trial period for \(String(rou.trialperiod)) then \(String(rou.productPrice))")
                        .font(.system(size: UIScreen.sH * 0.02, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 5)
                }
                else
                {
                    Text("Billed every \(String(rou.subperiod)) at \(String(rou.productPrice))")
                        .font(.system(size: UIScreen.sH * 0.02, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 5)
                }
                Spacer()
            }
        }
    }
    
    var links: some View{
        HStack{
                Link("Privacy Policy", destination: URL(string: "http://romanagq.beget.tech/privacy-policy")!)
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                Text("        ")
                    .font(.system(size: 11))
                    .foregroundColor(Color.white)
            Button(action: {rou.restore()})
                {
                    Text("Restore")
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                }
                Text("        ")
                    .font(.system(size: 11))
                    .foregroundColor(Color.black)
                Link("Terms Of Use", destination: URL(string: "http://romanagq.beget.tech/terms-conditions")!)
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
        }
        .padding(.bottom, 20)
    }

    var body: some View{
        ZStack{
            back
            VStack{
                Spacer()
                Button(action: {rou.subscribe()})
                {
                    Image("subscribe")
                }
                links
                    .padding(.top)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct paywall_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            paywallView(rou: router())
        }
    }
}


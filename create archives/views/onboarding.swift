//
//  onboarding.swift
//  create archives
//
//  Created by Кирилл on 31.10.2022.
//

import Foundation
import SwiftUI

enum pageOnb{
    case onb1
    case onb2
    case onb3
    case onb4
}

struct onboarding: View{
    
    @State var page: pageOnb = .onb1
    @StateObject var rou: router
    var onb1: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("onb1")
                    .padding(.top, UIScreen.sH * 0.1)
                Text("Manage your files")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.03, weight: .bold))
                    .padding(.top, UIScreen.sH * 0.06)
                    .padding(.bottom, UIScreen.sH * 0.02)
                Text("Add files to folders and\n organize your workspace")
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.025))
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
    
    var onb2: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("onb2")
                    .padding(.top, UIScreen.sH * 0.1)
                Text("Create archives")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.03, weight: .bold))
                    .padding(.top, UIScreen.sH * 0.04)
                    .padding(.bottom, UIScreen.sH * 0.02)
                Text("Archive your files and folders\n to save storage space")
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.02))
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
    
    var onb3: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("onb3")
                    .padding(.top, UIScreen.sH * 0.1)
                Text("Unpack archives")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.03, weight: .bold))
                    .padding(.top, UIScreen.sH * 0.01)
                    .padding(.bottom, UIScreen.sH * 0.01)
                Text("Unzip the archives to have access\n to the files and folders inside")
                    .foregroundColor(Color.white)
                    .font(.system(size: UIScreen.sH * 0.02))
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
    
    var onb4: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Button(action: {rou.currentPage0 = .main})
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
    
    func moveOnb(){
        if (page == .onb1)
        {
            page = .onb2
            return
        }
        if (page == .onb2)
        {
            page = .onb3
            return
        }
        if (page == .onb3)
        {
            page = .onb4
            return
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
            switch page{
            case .onb1:
                onb1
            case .onb2:
                onb2
            case .onb3:
                onb3
            case .onb4:
                onb4
            }
            VStack{
                Spacer()
                if (page != .onb4){
                    Button(action: {moveOnb()})
                    {
                        Image("continue")
                    }
                }
                else{
                    Button(action: {rou.subscribe()})
                    {
                        Image("subscribe")
                    }
                }
                links
                    .padding(.top)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct onb_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            onboarding(rou: router())
        }
    }
}

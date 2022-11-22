//
//  settings.swift
//  create archives
//
//  Created by Кирилл on 31.10.2022.
//

import Foundation
import SwiftUI

struct settings: View{
    
    @State var isVis = false
    @StateObject var rou: router

    func shareApp()
    {
        if let name = URL(string: "https://apps.apple.com/us/app/zip-7z-archive/id6444102864"), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        } else {
          // show alert for not available
        }
    }

    var head: some View{
        HStack{
            Text("Settings")
                .foregroundColor(Color.white)
                .font(.system(size: UIScreen.sH / 20, weight: .bold))
            Spacer()
        }
        .padding(.horizontal)
    }
    

    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                head
                Button(action:{rou.currentPage0 = .paywall})
                {
                    Image("settings0")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                Link(destination: URL(string: "http://romanagq.beget.tech")!){
                    Image("settings1")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                Link(destination: URL(string: "http://romanagq.beget.tech/terms-conditions")!){
                    Image("settings2")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                Link(destination: URL(string: "http://romanagq.beget.tech/privacy-policy")!){
                    Image("settings3")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                Link(destination: URL(string: "http://romanagq.beget.tech")!){
                    Image("settings4")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                Button(action:{shareApp()}){
                    Image("settings5")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                Spacer()
            }
        }
    }
}

struct settings_Previews: PreviewProvider {
    static var previews: some View {
        settings(rou: router())
    }
}

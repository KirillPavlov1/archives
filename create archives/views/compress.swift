//
//  compress.swift
//  create archives
//
//  Created by Кирилл on 29.10.2022.
//

import Foundation
import SwiftUI
import ApphudSDK

struct compressView: View{

    let persistenceController = PersistenceController.shared
    @Binding var isVis: Bool
    @State var videos = false
    @State var images = false
    @State var files = false
    var inFolder: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var itemsSwitchON: [ObjectArchive]
    @Binding var isLoading: Bool
    @StateObject var rou: router
    
    func createArchive(){
        if (Apphud.hasActiveSubscription()){
            isLoading = true
            DispatchQueue.global(qos: .background).async {
                sleep(1)
                DispatchQueue.main.async {
                    var a = archiveCreate(isLoading: $isLoading)
                    a.createZip(itemsSwitchON)
                }
            }
        }
        else{
            rou.currentPage0 = .paywall
        }
    }
    
    func create7zArchive(){
        if (Apphud.hasActiveSubscription()){
            isLoading = true
            DispatchQueue.global(qos: .background).async {
                sleep(1)
                DispatchQueue.main.async {
                    let a = archiveCreate(isLoading: $isLoading)
                    a.create7z(itemsSwitchON)
                }
            }
        }
        else{
            rou.currentPage0 = .paywall
        }
    }

    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Button(action:{createArchive()}){
                    Image("compress1")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                        
                }
                Button(action:{create7zArchive()}){
                    Image("compress2")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
            }
            .padding(.bottom, UIScreen.sH * 0.13)
        }
        .onTapGesture {
            isVis = false
        }
    }
}

struct compressView_Previews: PreviewProvider {
    static var previews: some View {
        compressView(isVis: .constant(true), inFolder: "", itemsSwitchON: .constant([]), isLoading: .constant(false), rou: router())
    }
}

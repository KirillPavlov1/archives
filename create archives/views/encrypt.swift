//
//  encrypt.swift
//  create archives
//
//  Created by Кирилл on 29.10.2022.
//

import Foundation
import SwiftUI
import ApphudSDK

struct encryptView: View{
    
    @Binding var isVis: Bool
    @State var videos = false
    @State var images = false
    @State var files = false
    var inFolder: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var itemsSwitchON: [ObjectArchive]
    @State var presentAlert = false
    @State var password: String = ""
    @State var zip: Bool = true
    @StateObject var rou: router
    @Binding var isLoading: Bool

    func subscribe1(){
        if (Apphud.hasActiveSubscription()){
            presentAlert = true
            zip = true
        }
        else{
            rou.currentPage0 = .paywall
        }
    }
    
    func subscribe2(){
        if (Apphud.hasActiveSubscription()){
            presentAlert = true
            zip = false
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
                Button(action:{subscribe1()}){
                    Image("encrypt1")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                        
                }
                Button(action:{subscribe2()}){
                    Image("encrypt2")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
            }
            .padding(.bottom, UIScreen.sH * 0.13)
            if presentAlert{
                AlertControllerView(textfieldText: $password, showingAlert: $presentAlert, alertTitle: "Password", alertMessage: "Password for archive", zip: $zip, itemsSwitchON: $itemsSwitchON, isLoading: $isLoading)
            }
        }
        .onTapGesture {
            isVis = false
        }
    }
}

struct encryptView_Previews: PreviewProvider {
    static var previews: some View {
        encryptView(isVis: .constant(true), inFolder: "", itemsSwitchON: .constant([]), rou: router(), isLoading: .constant(false))
    }
}

//
//  compress.swift
//  create archives
//
//  Created by Кирилл on 29.10.2022.
//

import Foundation
import SwiftUI

struct compressView: View{

    let persistenceController = PersistenceController.shared
    @Binding var isVis: Bool
    @State var videos = false
    @State var images = false
    @State var files = false
    var inFolder: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var itemsSwitchON: [ObjectArchive]
    
    func createArchive(){
        var a = archiveCreate()
        a.createZip(itemsSwitchON)
    }
    
    func create7zArchive(){
        let a = archiveCreate()
        a.create7z(itemsSwitchON)
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
        compressView(isVis: .constant(true), inFolder: "", itemsSwitchON: .constant([]))
    }
}

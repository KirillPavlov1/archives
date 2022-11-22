//
//  mother1.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import Foundation
import SwiftUI

struct Mother1: View{

    @StateObject var rou: router
    @State var editing = false
    @State var isVis = false
    @Environment(\.managedObjectContext) private var viewContext
    @State var itemsSwitchON: [ObjectArchive] = []
    @State var compress = false
    @State var encrypt = false

    func deleteitemsSwitchON(){
        for i in itemsSwitchON{
            do{
                try FileManager.default.removeItem(at: URL(string: i.data!)!)
                viewContext.delete(i)
            }
            catch{
                print(error)
            }
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    var tab: some View{
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.122, green: 0.122, blue: 0.161).opacity(0.75))
                    .frame(height: UIScreen.sH * 0.15)
                HStack{
                    Button(action: {rou.currentPage1 = .home})
                    {
                        if (rou.currentPage1 == .home){
                            VStack{
                                Image("home_on")
                                    .resizable()
                                    .frame(width: UIScreen.sW * 0.07, height: UIScreen.sW * 0.07)
                                Image("point")
                            }
                        }
                        else{
                            Image("home_off")
                                .resizable()
                                .frame(width: UIScreen.sW * 0.07, height: UIScreen.sW * 0.07)
                        }
                    }
                    Button(action: {isVis = true})
                    {
                        Image("plus")
                            .padding(.horizontal, UIScreen.sW * 0.13)
                    }
                    Button(action: {rou.currentPage1 = .settings})
                    {
                        if (rou.currentPage1 == .settings){
                            VStack{
                                Image("set_on")
                                    .resizable()
                                    .frame(width: UIScreen.sW * 0.07, height: UIScreen.sW * 0.07)
                                Image("point")
                            }
                        }
                        else{
                            Image("set_off")
                                .resizable()
                                .frame(width: UIScreen.sW * 0.07, height: UIScreen.sW * 0.07)
                        }
                    }
                }
                .padding(.bottom, UIScreen.sH * 0.04)
            }
        }
        .frame(height: UIScreen.sH * 0.1)
    }

    var tabCompress: some View{
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.122, green: 0.122, blue: 0.161).opacity(0.75))
                    .frame(height: UIScreen.sH * 0.15)
                HStack{
                    Button(action: {compress = true; encrypt = false})
                    {
                        VStack{
                            Image("compress")
                                .resizable()
                                .frame(width: UIScreen.sW * 0.06, height: UIScreen.sW * 0.06)
                            Text("Compress")
                                .foregroundColor(Color.white)
                        }
                    }
                    Button(action: {encrypt = true; compress = false})
                    {
                        VStack{
                        Image("encrypt")
                            .resizable()
                            .frame(width: UIScreen.sW * 0.06, height: UIScreen.sW * 0.06)
                            .padding(.horizontal, UIScreen.sW * 0.13)
                        Text("Encrypt")
                            .foregroundColor(Color.white)
                        }
                    }
                    Button(action: {deleteitemsSwitchON()})
                    {
                        VStack{
                        Image("delete")
                            .resizable()
                            .frame(width: UIScreen.sW * 0.06, height: UIScreen.sW * 0.06)
                        Text("Delete")
                            .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(.bottom, UIScreen.sH * 0.04)
            }
        }
        .frame(height: UIScreen.sH * 0.1)
    }
    
    var body: some View{
        ZStack{
            switch rou.currentPage1 {
                case .home:
                home(isVis: $isVis, editing: $editing, compress: $compress, encrypt: $encrypt, itemsSwitchON: $itemsSwitchON, rou: rou)
                
                case .settings:
                settings(rou: rou)
            }
            VStack{
                Spacer()
                if (editing)
                {
                    tabCompress
                }
                else
                {
                    tab
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            if (isVis){
                addView(isVis: $isVis)
            }
        }
    }
}

struct Mother1_Previews: PreviewProvider {
    static var previews: some View {
        Mother1(rou: router())
    }
}

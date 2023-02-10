//
//  ContentView.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import SwiftUI
import CoreData

struct activeSort{
    enum abcd{
        case name
        case type
        case time
        case size
    }
    var current: abcd = .name
    var down = true
}

struct home: View {
 
    @State var abcd = activeSort()
    @Binding var isVis: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default)
    public var items: FetchedResults<ObjectArchive>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name, order: .reverse)],
        animation: .default)
    public var itemsReverse: FetchedResults<ObjectArchive>
    @State var isReverse = false
    @Binding var editing: Bool
    @Binding var compress: Bool
    @Binding var encrypt: Bool
    @Binding var itemsSwitchON: [ObjectArchive]
    @State var sortDescriptor: NSSortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.name, ascending: true)
    @StateObject var rou: router
    @State var searchOn = false
    @State var searchText = ""
    @Binding var isLoading: Bool

    func clearitemsSwitchON(){
        //itemsSwitchON.removeAll()
    }

    func changeName()
    {
        if (abcd.current == .name)
        {
            abcd.down.toggle()
            if (abcd.down == true){
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.name, ascending: true)
            }
            else{
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.name, ascending: false)
            }
        }
        else
        {
            abcd.current = .name
        }
    }

    func changeType()
    {
        if (abcd.current == .type)
        {
            abcd.down.toggle()
            if (abcd.down == true){
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.type, ascending: true)
            }
            else{
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.type, ascending: false)
            }
        }
        else
        {
            abcd.current = .type
        }
    }

    func changeTime()
    {
        if (abcd.current == .time)
        {
            abcd.down.toggle()
            if (abcd.down == true){
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.day, ascending: true)
            }
            else{
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.day, ascending: false)
            }
        }
        else
        {
            abcd.current = .time
        }
    }

    func changeSize()
    {
        if (abcd.current == .size)
        {
            abcd.down.toggle()
            if (abcd.down == true){
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.sizeInt, ascending: true)
            }
            else{
                sortDescriptor = NSSortDescriptor(keyPath: \ObjectArchive.sizeInt, ascending: false)
            }
        }
        else
        {
            abcd.current = .size
        }
    }

    var editSort: some View{
        HStack{
            Button(action: {
                changeName(); isReverse.toggle()
            })
            {
                if (abcd.current == .name)
                {
                    HStack{
                        Text("Name")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        abcd.down == true ? Image("down") : Image("up")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                    .background(Color(red: 0.388, green: 0.388, blue: 0.4))
                    .cornerRadius(25)
                }
                else
                {
                    HStack{
                        Text("Name")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        Image("down")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                }
            }
            Spacer()
            Button(action: {
                changeType()
            })
            {
                if (abcd.current == .type)
                {
                    HStack{
                        Text("Type")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        abcd.down == true ? Image("down") : Image("up")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                    .background(Color(red: 0.388, green: 0.388, blue: 0.4))
                    .cornerRadius(25)
                }
                else
                {
                    HStack{
                        Text("Type")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        Image("down")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                }
            }
            Spacer()
            Button(action: {
                changeTime()
            })
            {
                if (abcd.current == .time)
                {
                    HStack{
                        Text("Time")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        abcd.down == true ? Image("down") : Image("up")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                    .background(Color(red: 0.388, green: 0.388, blue: 0.4))
                    .cornerRadius(25)
                }
                else
                {
                    HStack{
                        Text("Time")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        Image("down")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                }
            }
            Spacer()
            Button(action: {
                changeSize()
            })
            {
                if (abcd.current == .size)
                {
                    HStack{
                        Text("Size")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        abcd.down == true ? Image("down") : Image("up")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                    .background(Color(red: 0.388, green: 0.388, blue: 0.4))
                    .cornerRadius(25)
                }
                else
                {
                    HStack{
                        Text("Size")
                            .foregroundColor(Color.white)
                            .font(.system(size: UIScreen.sH * 0.025))
                        Image("down")
                    }
                    .frame(height: 0.05 * UIScreen.sH)
                    .padding(.horizontal, 5)
                }
            }
        }
        .frame(width: UIScreen.sW * 0.95, height: 0.06 * UIScreen.sH)
        .background(Color(red: 0.2, green: 0.2, blue: 0.247))
        .cornerRadius(20)
    }

    var head: some View{
        HStack{
            Text("Files")
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .font(.system(size: UIScreen.sH / 20, weight: .bold))
            Spacer()
            Button(action:{searchOn = true}){
                Image("search")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.07, height: UIScreen.sW * 0.07)
                    .padding(.trailing)
            }
            Button(action: {editing.toggle()}){
                Image("pen")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.07, height: UIScreen.sW * 0.07)
            }
        }
        .padding(.horizontal)
    }

    
    var search: some View{
        HStack{
            HStack {
                Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
                TextField("Search...", text: $searchText)
                .frame(height: UIScreen.sH * 0.05)
            }
            .foregroundColor(Color.white)
            .frame(width: UIScreen.sW * 0.8, height: UIScreen.sH * 0.05)
            .background(Color(red: 0.232, green: 0.232, blue: 0.242))
            .clipShape(RoundedRectangle(cornerRadius:20))
            .padding(.leading)
            Spacer()
            Button(action: {searchOn = false})
            {
                Image(systemName: "multiply")
                    .foregroundColor(Color.gray)
                    .padding(.trailing)
                    .scaleEffect(2)
            }
        }
        .padding(.vertical)
    }

    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 0.122, green: 0.122, blue: 0.161))
                .edgesIgnoringSafeArea(.all)
            VStack{
                if (!searchOn){
                    head
                }
                else{
                    search
                }
                editSort
                    .padding(.bottom, UIScreen.sH * 0.03)
                ListView(sortDescripter: sortDescriptor, editing: $editing, itemsSwitchON: $itemsSwitchON, searchText: $searchText)
            }
            VStack{
                if (compress)
                {
                    compressView(isVis: $compress, itemsSwitchON: $itemsSwitchON, isLoading: $isLoading, rou: rou)
                }
                if (encrypt)
                {
                    encryptView(isVis: $encrypt, itemsSwitchON: $itemsSwitchON, rou: rou, isLoading: $isLoading)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        home(isVis: .constant(false), editing: .constant(false), compress: .constant(false), encrypt: .constant(false), itemsSwitchON: .constant([]), rou: router(), isLoading: .constant(false))
    }
}

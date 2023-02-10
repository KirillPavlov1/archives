//
//  listView.swift
//  create archives
//
//  Created by Кирилл on 30.10.2022.
//

import Foundation
import SwiftUI
import CoreData

struct ListView: View {
    @FetchRequest var items: FetchedResults<ObjectArchive>
    @Environment(\.managedObjectContext) var viewContext
    @Binding var editing: Bool
    @Binding var itemsSwitchON: [ObjectArchive]
    @State var switchON = false
    @Binding var searchText: String

    init(sortDescripter: NSSortDescriptor, editing: Binding<Bool>, itemsSwitchON:  Binding<[ObjectArchive]>, searchText: Binding<String>) {
        let request: NSFetchRequest<ObjectArchive> = ObjectArchive.fetchRequest()
        request.sortDescriptors = [sortDescripter]
        _items = FetchRequest<ObjectArchive>(fetchRequest: request)
        _editing = editing
        _itemsSwitchON = itemsSwitchON
        _searchText = searchText
    }

    func toShare(s: String){
        let newUrl = URL(string: "file://" + s)
        let activityVC = UIActivityViewController(activityItems: [newUrl], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(items){ item in
                    if (strncmp(item.name, searchText, strlen(searchText)) == 0  && items.contains(item)){
                        FileImageVideo(editing: $editing, itemsSwitchON: $itemsSwitchON, item: item)
                    }
                }
            }
            .padding(.bottom, UIScreen.sH * 0.15)
        }
    }
}

//
//  file manager.swift
//  create archives
//
//  Created by Кирилл on 25.10.2022.
//

import Foundation
import SwiftUI

struct FilePicker: UIViewControllerRepresentable {

    var path: String?
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ObjectArchive.data, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ObjectArchive>

    private func plusFile(fURL: String) {
        let date = Date()
        if (fURL != "")
        {
            let new = ObjectArchive(context: viewContext)
            new.type = "f"
            new.day = date
            new.name = "file" + String(items.count  + 1)
            new.data = fURL
            new.size = URL(string: fURL)?.fSString
            new.sizeInt = Int64(Int(URL(string: fURL)!.fS))
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func makeCoordinator() -> FilePicker.Coordinator {
        return FilePicker.Coordinator(father1: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<FilePicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: FilePicker.UIViewControllerType, context: UIViewControllerRepresentableContext<FilePicker>) {
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var father: FilePicker
        
        init(father1: FilePicker){
            father = father1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
            father.path = urls[0].absoluteString
            self.father.plusFile(fURL: father.path!)
        }
    }
}

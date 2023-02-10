//
//  file manager.swift
//  create archives
//
//  Created by Кирилл on 25.10.2022.
//

import Foundation
import SwiftUI

struct FilePicker: UIViewControllerRepresentable {

    @State var path: URL = URL(string: "https://www.apple.com")!
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ObjectArchive.data, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ObjectArchive>
    @State var fileContent = ""

    private func plusFile() {
        let date = Date()
        if ((path.absoluteString) != "https://www.apple.com")
        {
            let fileManager = FileManager.default
            let documentsFolder: URL? = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            var folderURL = documentsFolder!.appendingPathComponent("filesFolder")
            let folderExists = (try? folderURL.checkResourceIsReachable()) ?? false
            let fileURL = URL(string: path.absoluteString)!
            let fileName = fileURL.lastPathComponent
            do {
                if !folderExists {
                    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false)
                }
                folderURL.appendPathComponent(String(describing: fileName))
                if FileManager.default.fileExists(atPath: folderURL.path) {
                    return
                }
                try fileManager.copyItem(at: fileURL, to: folderURL)
            } catch { print(error) }
            let new = ObjectArchive(context: viewContext)
            new.type = "f"
            new.day = date
            new.name = "file" + String(items.count  + 1)
            new.data = folderURL.absoluteString
            new.size = URL(string: new.data!)?.fSString
            new.sizeInt = Int64(Int(URL(string: new.data!)!.fS))
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
            do {
                if urls[0].startAccessingSecurityScopedResource() {
                father.path = urls[0]
                father.plusFile()
                do { urls[0].stopAccessingSecurityScopedResource() }
                }
                else {
                            // Handle denied access
                }
                } catch {
                        // Handle failure.
                    print("Unable to read file contents")
                    print(error.localizedDescription)
                }
           
        }
    }
}

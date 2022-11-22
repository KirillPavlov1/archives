//
//  archives.swift
//  create archives
//
//  Created by Кирилл on 31.10.2022.
//

import Foundation
import SwiftUI
import Zip
import SSZipArchive
import CoreData
import PLzmaSDK

struct archiveCreate{
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default)
    public var itemsDB: FetchedResults<ObjectArchive>

    func saveToCD(){

    }
    
    func createZipEncrypt(_ password: String, _ items: [ObjectArchive]){
        do {
            let persistenceController = PersistenceController.shared
            let viewContext = persistenceController.container.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ObjectArchive")
            let countOfItems = try! viewContext.count(for: fetchRequest)
            var urlArray: [URL] = []
            for item in items{
                urlArray.append(URL(string: item.data!)!)
            }
            let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let documentsFolder = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
            let count = try? FileManager.default.contentsOfDirectory(at: documentsDirectoryURL!, includingPropertiesForKeys: []).count
            let zipFilePath: URL? = documentsDirectoryURL?.appendingPathComponent("archive" + String(countOfItems + 1) + ".zip")
            let folderPath = documentsDirectoryURL!.appendingPathComponent("folder")
            try? FileManager.default.createDirectory(atPath: folderPath.path, withIntermediateDirectories: false, attributes: nil)
            for i in urlArray{
                try! FileManager.default.copyItem(atPath: i.path, toPath: folderPath.path + "/" + i.lastPathComponent)
            }
            SSZipArchive.createZipFile(atPath: zipFilePath!.path, withContentsOfDirectory: folderPath.path, keepParentDirectory: false, withPassword: password)
            let date = Date()
            let new = ObjectArchive(context: viewContext)
            new.type = "a"
            new.day = date
            new.name = "zip" + String(String(countOfItems + 1))
            new.data = zipFilePath?.absoluteString
            new.size = zipFilePath?.fSString
            new.sizeInt = Int64(Int(URL(string: new.data!)!.fS))
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        catch {
          print("Something went wrong")
        }
    }
    
    func create7z(_ items: [ObjectArchive]){
        do {
            let persistenceController = PersistenceController.shared
            let viewContext = persistenceController.container.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ObjectArchive")
            let countOfItems = try! viewContext.count(for: fetchRequest)
            let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // 1. Create output stream for writing archive's file content.
            //  1.1. Using file path.
            let archivePath = documentsDirectoryURL?.appendingPathComponent("archive" + String(countOfItems + 1) + ".7z").path
            let archivePathOutStream = try! OutStream(path: Path(archivePath!))
            // 2. Create encoder with output stream, type of the archive, compression method and optional progress delegate.
            let encoder = try! Encoder(stream: archivePathOutStream, fileType: .sevenZ, method: .LZMA2)
            //  2.2. Setup archive properties.
            try! encoder.setCompressionLevel(9)
            var urlArray: [URL] = []
            for item in items{
                urlArray.append(URL(string: item.data!)!)
            }
            for i in urlArray{
                try! encoder.add(path: Path(i.path), mode: .default, archivePath: Path(i.lastPathComponent))
            }
            // 4. Open.
            let opened = try! encoder.open()
            // 4. Compress.
            let compressed = try! encoder.compress()
            let date = Date()
            let new = ObjectArchive(context: viewContext)
            new.type = "a"
            new.day = date
            new.name = "7z" + String(String(countOfItems + 1))
            new.data = archivePath
            new.size = URL(string: archivePath!)?.fSString
            new.sizeInt = Int64(Int(URL(string: new.data!)!.fS))
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        } catch let exception as Exception {
                print("Exception: \(exception)")
        }
    }
    
    func create7zEncrypt(_ password: String,_ items: [ObjectArchive]){
        do {
            let persistenceController = PersistenceController.shared
            let viewContext = persistenceController.container.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ObjectArchive")
            let countOfItems = try! viewContext.count(for: fetchRequest)
            let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // 1. Create output stream for writing archive's file content.
            //  1.1. Using file path.
            let archivePath = documentsDirectoryURL?.appendingPathComponent("archive" + String(countOfItems + 1) + ".7z").path
            let archivePathOutStream = try! OutStream(path: Path(archivePath!))
            // 2. Create encoder with output stream, type of the archive, compression method and optional progress delegate.
            let encoder = try! Encoder(stream: archivePathOutStream, fileType: .sevenZ, method: .LZMA2)
            try! encoder.setPassword(password)
            //  2.2. Setup archive properties.
            try! encoder.setShouldEncryptHeader(true)  // use this option with password.
            try! encoder.setShouldEncryptContent(true) // use this option with password.
            try! encoder.setCompressionLevel(9)
            var urlArray: [URL] = []
            for item in items{
                urlArray.append(URL(string: item.data!)!)
            }
            for i in urlArray{
                try! encoder.add(path: Path(i.path), mode: .default, archivePath: Path(i.lastPathComponent))
            }
            // 4. Open.
            let opened = try! encoder.open()
            // 4. Compress.
            let compressed = try! encoder.compress()
            let date = Date()
            let new = ObjectArchive(context: viewContext)
            new.type = "a"
            new.day = date
            new.name = "7z" + String(String(countOfItems + 1))
            new.data = archivePath
            new.size = URL(string: archivePath!)?.fSString
            new.sizeInt = Int64(Int(URL(string: new.data!)!.fS))
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        } catch let exception as Exception {
                print("Exception: \(exception)")
        }
    }

    func createZip(_ items: [ObjectArchive]){
        do {
            let persistenceController = PersistenceController.shared
            let viewContext = persistenceController.container.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ObjectArchive")
            let countOfItems = try! viewContext.count(for: fetchRequest)
            var urlArray: [URL] = []
            for item in items{
                urlArray.append(URL(string: item.data!)!)
            }
            let zipFilePath = try Zip.quickZipFiles(urlArray, fileName: "archive" + String(countOfItems + 1)) // Zi
            let date = Date()
            let new = ObjectArchive(context: viewContext)
            new.type = "a"
            new.day = date
            new.name = "zip" + String(String(countOfItems + 1))
            new.data = zipFilePath.absoluteString
            new.size = zipFilePath.fSString
            new.sizeInt = Int64(Int(URL(string: new.data!)!.fS))
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        catch {
          print("Something went wrong")
        }
    }
    
}

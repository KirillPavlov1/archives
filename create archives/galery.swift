//
//  galery.swift
//  create archives
//
//  Created by Кирилл on 26.10.2022.
//

import Foundation
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    var imgs: [UIImage] = []
    @Binding var show: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ObjectArchive.data, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ObjectArchive>

    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images // filter only to images
        configuration.selectionLimit = 0 // ignore limit
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator // Use Coordinator for delegation
        return photoPickerViewController
    }
  
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context){

    }
    
    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }

    func saveAsPNG(newIm: UIImage) -> URL? {
        let url: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let n = try? FileManager.default.contentsOfDirectory(at: url!, includingPropertiesForKeys: []).count
        let newURL: URL? = url?.appendingPathComponent("picture" + String(n!) + ".png")
        let d: Data = newIm.pngData()!
        try! d.write(to: newURL!)
        return newURL
    }

    func addImage() {
        let date = Date()
        if (imgs.count != 0)
        {
            for i in 0...imgs.count - 1{
                let new = ObjectArchive(context: viewContext)
                new.type = "i"
                new.day = date
                new.name = "picture" + String(items.count  + 1)
                new.data = saveAsPNG(newIm: imgs[i])?.absoluteString
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
    }

    class Coordinator: PHPickerViewControllerDelegate {
        
        private var father: ImagePicker
          
        init(_ father: ImagePicker) {
            self.father = father
        }
      
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let group = DispatchGroup()
            for result in results {
                group.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (obj, error) in
                    if let picture = obj as? UIImage {
                        DispatchQueue.main.async {
                            self.father.imgs.append(picture)
                            group.leave()
                        }
                    }
                })
            }
            father.show = false
            group.notify(queue: .main) {
                self.father.addImage()
            }
        }
    }
}

struct VideosPicker: UIViewControllerRepresentable {

    @State var video: URL = URL(string: "https://www.apple.com")!
    @Binding var show: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ObjectArchive.data, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ObjectArchive>
    
    private func addVideo() {
        let date = Date()
        if ((video.absoluteString) != "https://www.apple.com")
        {
            let new = ObjectArchive(context: viewContext)
            new.type = "v"
            new.day = date
            new.name = "video" + String(items.count  + 1)
            let fileManager = FileManager.default
            let documentsFolder: URL? = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            var folderURL = documentsFolder!.appendingPathComponent("videoFolder")
            let folderExists = (try? folderURL.checkResourceIsReachable()) ?? false
            let fileURL = URL(string: video.absoluteString)!
            let fileName = fileURL.lastPathComponent
            do {
                if !folderExists {
                    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false)
                }
                folderURL.appendPathComponent(String(describing: fileName))
                try fileManager.copyItem(at: fileURL, to: folderURL)
            } catch { print(error) }
            new.data = folderURL.absoluteString
            new.size = URL(string: new.data!)?.fSString
            new.sizeInt = Int64(Int(URL(string: new.data!)!.fS))
            do {
                try viewContext.save()
            }
            catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let father: VideosPicker

        init(_ father: VideosPicker) {
            self.father = father
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let video = info[.mediaURL] as? URL {
                father.video = video
            }
            father.show = false
            father.addVideo()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideosPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.movie"]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<VideosPicker>) {
    }
}

//
//  utils.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import Foundation
import SwiftUI

extension UIScreen{
    static let sW = UIScreen.main.bounds.size.width
    static let sH = UIScreen.main.bounds.size.height
}

extension Date {
        func timeAgoDisplay() -> String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: Date())
        }
}
extension URL {
     var attributes: [FileAttributeKey : Any]? {
         do {
             return try FileManager.default.attributesOfItem(atPath: path)
         } catch let error as NSError {
             print("FileAttribute error: \(error)")
         }
         return nil
     }

     var fS: UInt64 {
         return attributes?[.size] as? UInt64 ?? UInt64(0)
     }

     var fSString: String {
         return ByteCountFormatter.string(fromByteCount: Int64(fS), countStyle: .file)
     }
 }

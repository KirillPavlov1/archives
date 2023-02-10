//
//  Alert.swift
//  create archives
//
//  Created by Кирилл on 01.11.2022.
//

import Foundation
import SwiftUI
import UIKit

struct AlertControllerView: UIViewControllerRepresentable {

    //Alert
    @Binding var textfieldText: String
    @Binding var showingAlert: Bool
    
    var alertTitle: String
    var alertMessage: String
    @Binding var zip: Bool
    @Binding var itemsSwitchON: [ObjectArchive]
    @Binding var isLoading: Bool
    //
    
    // A Coordinator class will coordinate our View Controller to the SwiftUI view giving us the ability to respond to changes
    func makeCoordinator() -> AlertControllerView.Coordinator {
        Coordinator(self)
    }
    
    func createEncryptArchive(){
        isLoading = true
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            DispatchQueue.main.async {
                let a = archiveCreate(isLoading: $isLoading)
                a.createZipEncrypt(textfieldText, itemsSwitchON)
            }
        }
    }
    
    func createEncrypt7zArchive(){
        isLoading = true
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            DispatchQueue.main.async {
                let a = archiveCreate(isLoading: $isLoading)
                a.create7zEncrypt(textfieldText, itemsSwitchON)
            }
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        
        var control: AlertControllerView
        init(_ control: AlertControllerView) {
            self.control = control
        }
        
        // This function links the TextField to the binding variable textFieldText
        func textFieldDidChangeSelection(_ textField: UITextField) {
            control.textfieldText = textField.text ?? ""
        }
    }
    
    //Creates the UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    // Sends data from SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        //Logic implementation for the alert
        if self.showingAlert {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            context.coordinator.alert = alert
            
            //Adding the textField to the alert
            alert.addTextField { textField in
                textField.placeholder = "Enter some text"
                textField.text = self.textfieldText
                textField.delegate = context.coordinator
                
            }
            
            //Adding actions for the buttons
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
                
                self.textfieldText = ""
            })
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
                if let textField = alert.textFields?.first, let text = textField.text {
                    self.textfieldText = text
                }
                if zip{
                    createEncryptArchive()
                }
                else{
                    createEncrypt7zArchive()
                }
            })
            //
            
            //To set a color for the buttons in the alert
            alert.view.tintColor = UIColor.systemBlue
            
            // Presents the alert and dismisses it on completion
            DispatchQueue.main.async {
                uiViewController.present(alert, animated: true, completion: {
                    self.showingAlert = false
                })
            }
        }
    }
}

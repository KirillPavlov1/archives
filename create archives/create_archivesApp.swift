//
//  create_archivesApp.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import SwiftUI
import ApphudSDK
import AppsFlyerLib
import AppTrackingTransparency

@main
struct create_archivesApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var rou = router()
    
    var body: some Scene {
        WindowGroup {
            Mother0(rou: rou)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Apphud.start(apiKey: "app_BCyCFS2C5iZwAuCt5xaTeygmujhWyD")
        registerForNotifications()
        AppsFlyerLib.shared().appsFlyerDevKey = "vdYoSxR3mpdVuty9GQA6Fd"
        AppsFlyerLib.shared().appleAppID = "6444102864"
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification), name: UIApplication.didBecomeActiveNotification,object: nil)
        
        return true
    }

    @objc func didBecomeActiveNotification() {
        AppsFlyerLib.shared().start()
        if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .denied:
                    print("AuthorizationSatus is denied")
                case .notDetermined:
                    print("AuthorizationSatus is notDetermined")
                case .restricted:
                    print("AuthorizationSatus is restricted")
                case .authorized:
                    print("AuthorizationSatus is authorized")
                @unknown default:
                    fatalError("Invalid authorization status")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Apphud.submitPushNotificationsToken(token: deviceToken, callback: nil)
    }
}



func registerForNotifications(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])    { (granted, error) in
    }
    UIApplication.shared.registerForRemoteNotifications()
    let content = UNMutableNotificationContent()
    content.title = "Get Create Archive!"
    content.sound = UNNotificationSound.default
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (5*3600), repeats: true)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    if (!Apphud.hasActiveSubscription())
    {
        UNUserNotificationCenter.current().add(request)
    }
}

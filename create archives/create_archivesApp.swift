//
//  create_archivesApp.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import SwiftUI
import ApphudSDK

@main
struct create_archivesApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Mother0()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Apphud.start(apiKey: "app_BCyCFS2C5iZwAuCt5xaTeygmujhWyD")
        registerForNotifications()
        return true
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
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 12 * 3600, repeats: true)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    if (!Apphud.hasActiveSubscription())
    {
        UNUserNotificationCenter.current().add(request)
    }
}

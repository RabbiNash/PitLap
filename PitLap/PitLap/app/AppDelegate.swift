//
//  AppDelegate.swift
//  PitLap
//
//  Created by Tinashe Makuti on 23/02/2025.
//


import Firebase
import FirebaseMessaging

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        return true
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "None")")
    }
    
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         Messaging.messaging().apnsToken = deviceToken
         print("APNs token registered with Firebase.")
     }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
          print("Failed to register for APNs with error: \(error.localizedDescription)")
      }
}

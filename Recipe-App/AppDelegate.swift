//
//  AppDelegate.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 02/10/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
}

// MARK: UISceneSession Lifecycle

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
}


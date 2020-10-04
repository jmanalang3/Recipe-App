//
//  SceneDelegate.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 02/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        /// FirebaseApp
        FirebaseApp.configure()
        
        /// App Appearance
        UINavigationBar.appearance().barTintColor = Palette.backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 20),
                                                            .foregroundColor: UIColor.white]
        UITabBar.appearance().barTintColor = Palette.backgroundColor
        UITableView.appearance().backgroundColor = .clear
        
        /// Core Data
        CoreDataManager.setUp(withDataModelName: CoreDataName.modelName,
                                    bundle: .main,
                                    persistentStoreName: CoreDataName.persistentName)
        
        var rootViewController = UIViewController()
        if Auth.auth().currentUser != nil {
            rootViewController = TabBarViewController()
        } else {
            rootViewController = CredentialViewController()
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}


}


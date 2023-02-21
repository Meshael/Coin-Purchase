//
//  Coin_PurchaseApp.swift
//  Coin Purchase
//
//  Created by Mashael Alharbi on 16/02/2023.
//

import SwiftUI
import UIKit

@main
struct Coin_PurchaseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        IAPManager.shared.fetchProducts()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        // **
        return UISceneConfiguration(name: "Defult Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // **
        
    }
    
}

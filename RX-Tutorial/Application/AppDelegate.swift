//
//  AppDelegate.swift
//  RX-Tutorial
//
//  Created by David Adel on 06/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: NewsVC()) // Your initial view controller.
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}


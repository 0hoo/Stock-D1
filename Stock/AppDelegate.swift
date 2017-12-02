//
//  AppDelegate.swift
//  Stock
//
//  Created by Kim Younghoo on 11/11/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //[C1-8]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: GroupsViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

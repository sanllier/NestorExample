//
//  AppDelegate.swift
//  NestorExample
//
//  Created by Alexander Goremykin on 06.06.17.
//  Copyright © 2017 Alexander Goremykin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = ViewController(nibName: nil, bundle: nil)
        window?.rootViewController = rootViewController

        window?.makeKeyAndVisible()

        return true
    }

}


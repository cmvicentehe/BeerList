//
//  AppDelegate.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.initializeWindow()
        return true
    }
    
    private func initializeWindow() {
        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)
        let categoriesWireframe = BeerCategoriesWireframe(window: window)
        categoriesWireframe.showCategories()
        self.window = window
        
    }
}


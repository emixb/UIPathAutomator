//
//  AppDelegate.swift
//  UIPathAutomator-SampleApp
//
//  Created by Emanuel Jarnea on 10/06/2018.
//  Copyright © 2018 Emanuel Jarnea. All rights reserved.
//

import UIKit
import UIPathAutomator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // These actions are executed sequentially
        
        let actions: [Action] = [
            
            // Tap on a button that displays an image
            ButtonAction.displays(image: #imageLiteral(resourceName: "settings")),
            // Tap on a button that contains some text
            ButtonAction.contains(text: "dismiss"),
            
            // Tap on a button that contains some text
            ButtonAction.contains(text: "Show Alert"),
            // Dismiss the current alert
            AlertAction.dismiss,

            // Tap on a button that displays an image
            ButtonAction.displays(image:#imageLiteral(resourceName: "alert")),
            // Dismiss the current alert
            AlertAction.dismiss,
            
            // Tap on a button that contains some text
            ButtonAction.contains(text: "View"),
            // Go back one step on the navigation stack
            NavigationAction.back,
            
            // Tap on a button identified by an accessibility id
            ButtonAction.accessibility(id: "view_list_button"),
            // Tap on a cell that contains some text
            CellAction.contains(text: "Entry 24"),
            // Tap on the back button
            ButtonAction.contains(text: "List"),
            // Tap on a cell found at given section and row
            CellAction.index(section: 0, row: 7),
            // Go back one step on the navigation stack
            NavigationAction.back,
             // Tap on the back button
            ButtonAction.contains(text: "Back"),
        ]
        
        let automator = Automator(actions: actions)
        automator.start()
        
        return true
    }
}


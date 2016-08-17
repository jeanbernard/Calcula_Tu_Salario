//
//  AppDelegate.swift
//  Calcula Tu Salario
//
//  Created by Jean Bernard on 6/30/16.
//  Copyright © 2016 Jean Bernard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    // Sets background to a blank/empty image
    //UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
    // Sets shadow (line below the bar) to a blank image
    //UINavigationBar.appearance().shadowImage = UIImage()
    // Sets the translucent background color
    //UINavigationBar.appearance().barTintColor = UIColor(red: 248/255, green: 180/255, blue: 45/255, alpha: 0.2)
   // UINavigationBar.appearance().tintColor = UIColor.whiteColor()
   // UINavigationBar.appearance().backgroundColor = UIColor(red: 248.0, green: 180.0, blue: 45, alpha: 0.5)
    // Set translucent. (Default value is already true, so this can be removed if desired.)
    //UINavigationBar.appearance().translucent = false
    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}


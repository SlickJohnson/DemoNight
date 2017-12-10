//
//  AppDelegate.swift
//  DemoNight
//
//  Created by Willie Johnson on 09/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // User is already signed-up, so we skip the signp screen
//    if isUserSignedUp() {
//      return true
//    }

    window = UIWindow(frame: UIScreen.main.bounds)

    let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    window?.rootViewController = storyboard.instantiateInitialViewController()

    window?.makeKeyAndVisible()
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}

// MARK: - Helper functions
extension AppDelegate {
  /// Check if there is a User in Realm.
  func isUserSignedUp() -> Bool {
    do {
      let realm = try Realm()

      // Grab the first User object (latest User).
      if realm.objects(User.self).first != nil {
        return true
      }

      return false
    } catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
}


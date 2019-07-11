//
//  AppDelegate.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        copyRealmDatabase { (error) in
//
//        }
        
        return true
    }
    
//    func copyRealmDatabase(_ failure: (_ error:NSError) -> Void)
//    {
//        let config = Realm.Configuration( schemaVersion: 2, migrationBlock: { migration, oldSchemaVersion in if (oldSchemaVersion < 2){
//            /// Updated HelloCustomer table with new colomn "customer_referee_number"
////            migration.enumerateObjects(ofType: HelloCustomer.className()) { (_, customer) in
////                customer?["customer_referee_number"] = ""
////            }
//            }})
//
//        Realm.Configuration.defaultConfiguration = config
//        let defaultURL =  Realm.Configuration.defaultConfiguration.fileURL!
//        let bundleRealmPath = Bundle.main.url(forResource: "Track", withExtension: "realm")
//
//        print("Realm File Path : \(bundleRealmPath?.absoluteString)")
//
//        if !FileManager.default.fileExists(atPath: defaultURL.path)
//        {
//            do
//            {
//                try FileManager.default.copyItem(at: bundleRealmPath!,  to: defaultURL)
//            }
//            catch let error as NSError
//            {
//                failure(error)
//            }
//        }
//    }
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


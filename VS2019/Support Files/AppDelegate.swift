//
//  AppDelegate.swift
//  VS2019
//
//  Created by Quân Đinh on 28.08.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // add objects from calories table
        if let path = Bundle.main.path(forResource: "calories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<Dictionary<String, String>> {
                    for obj in jsonResult {
                        let foodObj = FoodObject(name: obj["Food_and_Serving"], calories: obj["Calories"],
                                                 caloriesFromFat: obj["Calories_from_Fat"], totalFat: obj["Total_Fat"],
                                                 Sodium: obj["Sodium"], potasium: obj["Potassium"],
                                                 totalCarboHydrate: obj["Total_Carbo_hydrate"],
                                                 sugars: obj["Sugars"], protein: obj["Protein"],
                                                 saturatedFat: obj["Saturated_Fat"], cholesterol: obj["Chole_sterol"],
                                                 type: obj["Food_Type"])
                        Static.calories.append(foodObj)
                    }
                }
            } catch {
                //
            }
        }
        
        return true
    }

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


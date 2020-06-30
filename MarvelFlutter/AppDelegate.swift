//
//  AppDelegate.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var flutterEngine = FlutterEngine(name: "engine")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupFlutter()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    func setupFlutter() {
        flutterEngine.run()
        let defaults = UserDefaults.standard
        
        let flutterChannel = FlutterMethodChannel(name: "marvel.flutter", binaryMessenger: flutterEngine.binaryMessenger)
        flutterChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "getDefaults":
                let isDarkModeOn = defaults.string(forKey: "isDarkModeOn") ?? ""
                let language = defaults.string(forKey: "language") ?? ""
                let defaultsMap: [String: String] = ["isDarkModeOn": isDarkModeOn, "language": language]
                
                result(defaultsMap)
            case "setDefaults":
                if let args = call.arguments as? [String: String] ,
                    let language = args["language"],
                    let isDarkModeOn = args["isDarkModeOn"] {
                    defaults.set(language, forKey: "language")
                    defaults.set(isDarkModeOn, forKey: "isDarkModeOn")
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

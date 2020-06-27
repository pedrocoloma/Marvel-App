//
//  SettingsTabCoordinator.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit
import Flutter

class SettingsTabCoordinator: AnyTabCoordinator {
    let settingsViewContrroller: UIViewController
    var rootController: UINavigationController
    var tabBarItem = UITabBarItem(title: "Settiings", image: #imageLiteral(resourceName: "icons8-settings-100"), tag: 3)
     
     init() {
        
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        settingsViewContrroller = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        settingsViewContrroller.title = "Settings"

         rootController = UINavigationController(rootViewController: settingsViewContrroller)
         rootController.tabBarItem = tabBarItem

     }
}

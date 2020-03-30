//
//  AppCoordinator.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

protocol AnyTabCoordinator {
    var rootController: UINavigationController { get set }
}

class AppCoordinator {
    
    var tabBarController: UITabBarController
    var tabs: [AnyTabCoordinator]
    var window: UIWindow?
    
    public init(window: UIWindow?) {
        self.tabBarController = UITabBarController()
        self.window = window
        window?.rootViewController = tabBarController
        
        let tabs = [
            CharactersTabCoordinator() as AnyTabCoordinator,
            ComicsTabCoordinator() as AnyTabCoordinator,
            SettingsTabCoordinator() as AnyTabCoordinator,
        ]
        
        self.tabs = tabs
    }
    
    public func start() {
        tabBarController.viewControllers = tabs.map { $0.rootController }
        window?.makeKeyAndVisible()
    }
}

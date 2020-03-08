//
//  AppCoordinator.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
    
    func start() {
        
    }
    
    
}

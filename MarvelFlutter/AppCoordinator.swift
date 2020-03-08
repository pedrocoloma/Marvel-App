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
    
    var listCoordinator = ListCoordinator()
    
    init(window: UIWindow?) {
        super.init()
        self.window = window
        navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        start()
    }
    
    override func start() {
//        listCoordinator = ListCoordinator()
//        listCoordinator.start()
        let listViewModel = HeroesListViewModel()
        listViewModel.coordinatorDelegate = self
        let heroesViewController = HeroesListViewController(viewModel: listViewModel)
        navigationController?.pushViewController(heroesViewController, animated: true)
    }
}

extension AppCoordinator: HeroesListViewModelCoorrdinator {
    func didSelect() {
        let heroesDetailsViewController = HeroesDetailsViewController()
        navigationController?.pushViewController(heroesDetailsViewController, animated: true)
    }
}

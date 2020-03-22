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
    
    var listCoordinator = ComicsCoordinator()
    
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
        let listViewModel = ComicsListViewModel()
        listViewModel.coordinatorDelegate = self
        let heroesViewController = ComicsListViewController(listViewModel)
        navigationController?.pushViewController(heroesViewController, animated: true)
    }
}

extension AppCoordinator: ComicsListViewModelCoorrdinatorDelegate {
    func didSelect(comic: Comic) {
        let heroesDetailsViewModel = ComicsDetailsViewModel(comic)
        let heroesDetailsViewController = ComicsDetailsViewController(heroesDetailsViewModel)
        navigationController?.pushViewController(heroesDetailsViewController, animated: true)
    }
}

//
//  ComicsTabCoordinator.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class ComicsTabCoordinator: AnyTabCoordinator {
    let comicsListViewModel: ComicsListViewModel
    let comicsListViewController: ComicsListViewController
    
    var rootController: UINavigationController
    
   var tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "icons8-magazine-100"), selectedImage: #imageLiteral(resourceName: "icons8-magazine-100"))
    
    init() {
        
        comicsListViewModel = ComicsListViewModel()
        comicsListViewController = ComicsListViewController(comicsListViewModel)

        rootController = UINavigationController(rootViewController: comicsListViewController)
        rootController.tabBarItem = tabBarItem
        
        comicsListViewModel.coordinatorDelegate = self
    }
    
}

extension ComicsTabCoordinator: ComicsListViewModelCoorrdinatorDelegate {
    func didSelect(comic: Comic) {
        let comicsDetailsViewModel = ComicsDetailsViewModel(comic)
        let comicsDetailsViewController = ComicsDetailsViewController(comicsDetailsViewModel)
        rootController.pushViewController(comicsDetailsViewController, animated: true)
    }
}

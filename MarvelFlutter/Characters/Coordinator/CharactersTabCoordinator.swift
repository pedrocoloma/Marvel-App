//
//  CharactersTabCoordinator.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class CharactersTabCoordinator: AnyTabCoordinator {
    let charactersListViewModel: CharactersListViewModel
    let charactersListViewController: CharactersListViewController

    var rootController: UINavigationController

    var tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "icons8-weak-person-100"), tag: 1)

    init() {
        charactersListViewModel = CharactersListViewModel()
        charactersListViewController = CharactersListViewController(charactersListViewModel)
        
        rootController = UINavigationController(rootViewController: charactersListViewController)
        rootController.tabBarItem = tabBarItem
        
        charactersListViewModel.coordinatorDelegate = self
    }
}

extension CharactersTabCoordinator: CharactersListViewModelCoordinatorrDelegate {
    func didSelect(character: Character) {
        let charactersDetailsViewModel = CharactersDetailsViewModel(character: character)
        let charactersDetailsViewController = CharactersDetailsViewController(charactersDetailsViewModel)
        rootController.pushViewController(charactersDetailsViewController, animated: true)
    }
    
}

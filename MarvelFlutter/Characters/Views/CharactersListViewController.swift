//
//  CharactersListViewController.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 29/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CharactersListViewModel?
    var searchController = UISearchController(searchResultsController: nil)
    var filteredCharacters: [Character] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ viewModel: CharactersListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.viewDelegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharactersListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.title = "Characters"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterCharacters(_ searchText: String) {
        filteredCharacters = viewModel?.characters?.filter { (character: Character) -> Bool in
            return character.name.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacters.count
        }
        return viewModel?.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharactersListTableViewCell
        let character: Character
        
        if isFiltering {
            character = filteredCharacters[indexPath.row]
        } else {
            character = (viewModel?.characters?[indexPath.row])!
        }
        
        cell?.setup(character: character)
        let cellViewModel = CharactersListCellViewModel(character: (viewModel?.characters?[indexPath.row])!)
        cellViewModel.viewDelegate = cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character: Character
        
        if isFiltering {
            character = filteredCharacters[indexPath.row]
        } else {
            character = (viewModel?.characters?[indexPath.row])!
        }
        
        viewModel?.didSelect(character: character)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180.0)
    }
}

extension CharactersListViewController: CharactersListViewModelViewDelegate {
    func didLoadCharacctersWithSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterCharacters(searchBar.text!)
    }
}

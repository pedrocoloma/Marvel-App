//
//  ComicsListViewController.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class ComicsListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ComicsListViewModel?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredComics: [Comic] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    required init?(coder aDeccoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ viewModel: ComicsListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ComicsDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        self.title = "Comics"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Comics"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterComics(_ searchText: String) {
        filteredComics = viewModel?.comics?.filter { (comic: Comic) -> Bool in
            return comic.title.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }
}

extension ComicsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredComics.count
        }
        return viewModel?.comics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ComicsDetailsTableViewCell
        let comic: Comic
        
        if isFiltering {
            comic =  (filteredComics[indexPath.row])
        } else {
            comic = (viewModel?.comics?[indexPath.row])!
        }
        
        cell?.setup(comic: comic)
        let cellViewModel = ComicsDetailsTableViewCellViewModel(comic: (viewModel?.comics?[indexPath.row])!)
        cellViewModel.viewDelegate = cell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic: Comic
        
        if isFiltering {
            comic =  (filteredComics[indexPath.row])
        } else {
            comic = (viewModel?.comics?[indexPath.row])!
        }
        
        viewModel?.didSelect(comic: comic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
}

extension ComicsListViewController: ComicsListViewModelViewDelegate {
    func didLoadComicsWithSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ComicsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searcchBar = searchController.searchBar
        filterComics(searcchBar.text!)
    }
}

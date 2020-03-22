//
//  HeroesViewController.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: HeroesListViewModel?

    required init?(coder aDeccoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ viewModel: HeroesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeroeListDetailsTableViewCell.self, forCellReuseIdentifier: "cell")

        self.title = "Comics"
    }
}

extension HeroesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.comics?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(row: indexPath.row)
    }
    
}

extension HeroesListViewController: HeroesListViewModelViewDelegate {
    func didLoadComicsWithSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

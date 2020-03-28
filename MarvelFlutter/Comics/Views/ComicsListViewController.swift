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
    }
}

extension ComicsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ComicsDetailsTableViewCell
        cell?.setup(comic: (viewModel?.comics?[indexPath.row])!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(row: indexPath.row)
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

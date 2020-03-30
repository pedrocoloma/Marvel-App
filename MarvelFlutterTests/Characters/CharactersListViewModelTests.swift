//
//  CharactersListViewModelTests.swift
//  MarvelFlutterTests
//
//  Created by Pedro Felipe Coloma de Araujo on 30/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import XCTest
@testable import MarvelFlutter

class CharactersListViewModelTests: XCTestCase {
    var selection = 0
    var viewModel: CharactersListViewModel!

    override func setUp() {
        viewModel = CharactersListViewModel()
        viewModel.coordinatorDelegate = self
        viewModel.viewDelegate = self
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testDidSelect() {
        viewModel.didSelect(character: Character(name: "", description: nil, thumbnail: nil, comics: CharactersComicsData(items: nil)))
        XCTAssertEqual(selection, 1)
    }
}

extension CharactersListViewModelTests: CharactersListViewModelCoordinatorrDelegate {
    func didSelect(character: Character) {
        selection = 1
    }
}

extension CharactersListViewModelTests: CharactersListViewModelViewDelegate {
    func didLoadCharacctersWithSuccess() {
        selection = 2
    }
}

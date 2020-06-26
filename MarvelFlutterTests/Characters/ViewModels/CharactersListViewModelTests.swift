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
    var shouldSucceed = true
    var viewModel: CharactersListViewModel!

    override func setUp() {
        viewModel = CharactersListViewModel()
        viewModel.coordinatorDelegate = self
        viewModel.viewDelegate = self
        viewModel.service = self
    }
    
    func testGetData() {
        shouldSucceed = false
        viewModel.getData()
        XCTAssertEqual(selection, 3)
        
        shouldSucceed = true
        viewModel.getData()
        XCTAssertEqual(selection, 2)
    }
    
    func testViewDelegates() {
        viewModel.viewDelegate?.didLoadCharacctersWithSuccess()
        XCTAssertEqual(selection, 2)
        
        viewModel.viewDelegate?.show(error: .unknown)
        XCTAssertEqual(selection, 3)
    }
   
    
    func testDidSelect() {
        viewModel.didSelect(character: Character(name: "", description: nil, thumbnail: nil, comics: CharactersComicsData(items: nil)))
        XCTAssertEqual(selection, 1)
    }
    
    override func tearDown() {
       viewModel = nil
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
    
    func show(error: MarvelError) {
        selection = 3
    }
}

extension CharactersListViewModelTests: CharactersServicing {
    func fetchCharacters(completion: @escaping (Result<[Character], MarvelError>) -> Void) {
        if shouldSucceed {
            completion(.success([]))
        } else {
            completion(.failure(.unknown))
        }
    }
    
    func downloadThumbnail(thumbnail: Thumbnail, completion: @escaping (Result<Data, MarvelError>) -> Void) {}
}

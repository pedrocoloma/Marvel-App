//
//  ComicsListViewModelTests.swift
//  MarvelFlutterTests
//
//  Created by Pedro Felipe Coloma de Araujo on 30/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import XCTest
@testable import MarvelFlutter

class ComicsListViewModelTests: XCTestCase {
    
    var selection = 0
    var shouldSucceed = true
    var viewModel: ComicsListViewModel!
    let comic = Comic(id: 1, title: "", description: nil, thumbnail: Thumbnail(path: "", extension: ""))
    
    override func setUp() {
        super.setUp()
        viewModel = ComicsListViewModel()
        viewModel.coordinatorDelegate = self
        viewModel.viewDelegate = self
        viewModel.service = self
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testDidSelect() {
        viewModel?.didSelect(comic: comic)
        XCTAssertEqual(selection, 1)
    }
    
    func testViewDelegates() {
        viewModel.viewDelegate?.didLoadComicsWithSuccess()
        XCTAssertEqual(selection, 2)
        
        viewModel.viewDelegate?.show(error: .unknown)
        XCTAssertEqual(selection, 3)
    }
     
     func testGetData() {
        shouldSucceed = true
        viewModel.getData()
        XCTAssertEqual(selection, 2)
        
        shouldSucceed = false
        viewModel.getData()
        XCTAssertEqual(selection, 3)
    }
}

extension ComicsListViewModelTests: ComicsListViewModelCoorrdinatorDelegate {
    func didSelect(comic: Comic) {
        selection = 1
    }
}

extension ComicsListViewModelTests: ComicsListViewModelViewDelegate {
    func didLoadComicsWithSuccess() {
        selection = 2
    }
    
    func show(error: MarvelError) {
        selection = 3
    }
}

extension ComicsListViewModelTests: ComicsServicing {
    func fetchComics(completion: @escaping (Result<[Comic]?, MarvelError>) -> Void) {
        if shouldSucceed {
            completion(.success([]))
        } else {
            completion(.failure(.unknown))
        }
    }
    
    func downloadComicsDetailsImage(thumbnail: Thumbnail, completion: @escaping (Result<Data, MarvelError>) -> Void) {}
}

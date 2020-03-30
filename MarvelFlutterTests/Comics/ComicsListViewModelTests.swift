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
    var viewModel: ComicsListViewModel!
    
    override func setUp() {
        viewModel = ComicsListViewModel()
        viewModel.coordinatorDelegate = self
        viewModel.viewDelegate = self
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testDidSelect() {
        viewModel?.didSelect(comic: Comic(id: 1, title: "", description: nil, thumbnail: Thumbnail(path: "", extension: "")))
        XCTAssertEqual(selection, 1)
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
}

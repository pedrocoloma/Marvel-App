//
//  ComicsDetailsViewModelTests.swift
//  MarvelFlutterTests
//
//  Created by Pedro Felipe Coloma de Araujo on 23/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import XCTest
@testable import MarvelFlutter

class ComicsDetailsViewModelTests: XCTestCase {
    
    var viewModel: ComicsDetailsViewModel!
    var selection = 0
    var shouldSucceed = true
    let comic = Comic(id: 1, title: "", description: nil, thumbnail: Thumbnail(path: "", extension: ""))
    
    override func setUp() {
        super.setUp()
        viewModel = ComicsDetailsViewModel(comic)
        viewModel.viewDelegate = self
        viewModel.service = self
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testViewDelegates() {
        viewModel.viewDelegate?.didLoadImageWithSuccess(image: Data())
        XCTAssertEqual(selection, 1)
        
        viewModel.viewDelegate?.show(error: .unknown)
        XCTAssertEqual(selection, 2)
    }
    
    func testGetImage() {
        shouldSucceed = true
        viewModel.getImage()
        XCTAssertEqual(selection, 1)
        
        shouldSucceed = false
        viewModel.getImage()
        XCTAssertEqual(selection, 2)
    }
    
}

extension ComicsDetailsViewModelTests: ComicsDetailsViewModelViewDelegate {
    func didLoadImageWithSuccess(image: Data) {
        selection = 1
    }
    
    func show(error: MarvelError) {
        selection = 2
    }
}

extension ComicsDetailsViewModelTests: ComicsServicing {
    func fetchComics(completion: @escaping (Result<[Comic]?, MarvelError>) -> Void) {}
    
    func downloadComicsDetailsImage(thumbnail: Thumbnail, completion: @escaping (Result<Data, MarvelError>) -> Void) {
        if shouldSucceed {
            completion(.success(Data()))
        } else {
            completion(.failure(.network))
        }
    }
}

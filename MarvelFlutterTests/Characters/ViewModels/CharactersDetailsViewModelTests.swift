//
//  CharactersDetailsViewModelTests.swift
//  MarvelFlutterTests
//
//  Created by Pedro Felipe Coloma de Araujo on 25/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import XCTest
@testable import MarvelFlutter

class CharactersDetailsViewModelTests: XCTestCase {
    
    var shouldSucceed = true
    var selection = 0
    var character = Character(name: "", description: "", thumbnail: Thumbnail(path: "", extension: ""), comics: CharactersComicsData())
    var viewModdel: CharactersDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewModdel = CharactersDetailsViewModel(character: character)
        viewModdel.viewDelegate = self
        viewModdel.service = self
    }
    
    override func tearDown() {
        viewModdel = nil
        super.tearDown()
    }
    
    func testGetImage() {
        shouldSucceed = true
        viewModdel.getImage()
        XCTAssertEqual(selection, 1)
        
        shouldSucceed = false
        viewModdel.getImage()
        XCTAssertEqual(selection, 2)
    }
    
    func testViewDelegates() {
        viewModdel.viewDelegate?.show(error: .unknown)
        XCTAssertEqual(selection, 2)
        
        viewModdel.viewDelegate?.show(image: Data())
        XCTAssertEqual(selection, 1)
    }
}

extension CharactersDetailsViewModelTests: CharactersDetailsViewModelViewDelegate {
    func show(image: Data) {
        selection = 1
    }
    
    func show(error: MarvelError) {
        selection = 2
    }
}

extension CharactersDetailsViewModelTests: CharactersServicing {
    func fetchCharacters(completion: @escaping (Result<[Character], MarvelError>) -> Void) {}
    
    func downloadThumbnail(thumbnail: Thumbnail, completion: @escaping (Result<Data, MarvelError>) -> Void) {
        if shouldSucceed {
            completion(.success(Data()))
        } else {
            completion(.failure(.network))
        }
    }
}

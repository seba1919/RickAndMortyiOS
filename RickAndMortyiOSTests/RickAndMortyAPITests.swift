//
//  RickAndMortyAPITests.swift
//  RickAndMortyiOSTests
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import XCTest
import RickAndMortyiOS
class RickAndMortyAPITests: XCTestCase {

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_getAllCharacters_performRequestForCharacters() {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let sut = RickAndMortyAPI(with: url,
                                  with: URLSessionHTTPClient(session: URLSession.shared))
        
        let exp = expectation(description: "Wait for request")
        sut.getAllCharacters { result in
            switch result {
            case let .success(characters):
                XCTAssertNotNil(characters)
                exp.fulfill()
                break
            case .failure:
                break
            }
        }

        wait(for: [exp], timeout: 1.0)
    }
}

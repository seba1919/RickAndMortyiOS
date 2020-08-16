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
    
    func test_getCharactersForPage_performRequestForCharacters() {
        let sut = RickAndMortyAPI(with: URLSessionHTTPClient.shared)
        
        let exp = expectation(description: "Wait for request")
        sut.getCharacters(forPage: 3) { result in
            switch result {
            case let .success(characters):
                XCTAssertNotEqual(characters.count, 0)
                exp.fulfill()
                break
            case .failure:
                break
            }
        }

        wait(for: [exp], timeout: 1.0)
    }
}

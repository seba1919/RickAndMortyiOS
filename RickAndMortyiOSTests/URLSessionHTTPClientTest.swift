//
//  URLSessionHTTPClientTest.swift
//  RickAndMortyiOSTests
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import XCTest
import RickAndMortyiOS

class URLSessionHTTPClientTest: XCTestCase {
    
    func test_getFromURL_performGetRequestFromURL() {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let sut = URLSessionHTTPClient(session: URLSession.shared)
        
        let exp = expectation(description: "Wait for request")
        sut.get(from: url) { response in
            switch response {
            case let .success((data, response)):
                XCTAssertNotNil(data)
                XCTAssertEqual(response.statusCode, 200)
                exp.fulfill()
                break
            case .failure(_):
                exp.fulfill()
                break
            }
        }
        wait(for: [exp], timeout: 1.0)
    }    
}

//
//  RickAndMortyAPI.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

public class RickAndMortyAPI: CharacterLoader {
    let client: HTTPClient
    let baseURL: URL
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private struct Root: Decodable {
        let results: [RickAndMortyCharacter]
        
        enum CodingKeys: String, CodingKey {
            case results = "results"
        }
    }
    
    public typealias Result = CharacterLoader.Result
    
    public init(with url: URL,
                with client: HTTPClient) {
        self.baseURL = url
        self.client = client
    }
    
    public func getAllCharacters(completion: @escaping ((Result) -> Void)) {
        client.get(from: baseURL) { result in
            switch result {
            case let .success(jsonData, response):
                if let characters = try? JSONDecoder().decode(Root.self, from: jsonData),
                response.statusCode == 200 {
                    completion(.success(characters.results))
                } else {
                    completion(.failure(Error.invalidData))
                }
                break
            case .failure:
                completion(.failure(Error.connectivity))
                break
            }
        }
    }
}


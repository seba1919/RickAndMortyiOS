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
    let baseURL = URL(string: "https://rickandmortyapi.com/api/character")!
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = CharacterLoader.Result
    
    public init(with client: HTTPClient) {
        self.client = client
    }
    
    public func getCharacters(forPage pageNumber: Int?, completion: @escaping
        (Result) -> Void) {
        client.get(from: baseURL, forPage: pageNumber) { result in
            switch result {
            case let .success((data, response)):
                completion(RickAndMortyAPI.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try RickAndMortyItemsMapper.map(data, from: response)
            return .success(items.toModels())
        }
        catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteRickAndMortyCharacterItem {
    func toModels() -> [RickAndMortyCharacter] {
        return map { characterItem in
            
            let imageURL = URL(string: characterItem.image)
            
            let gender: RickAndMortyCharacterGender
            switch characterItem.gender {
            case .female:
                gender = .female
            case .male:
                gender = .male
            case .genderless:
                gender = .genderless
            case .unknown:
                gender = .unknown
                
            }
            
            let characterStatus: RickAndMortyCharacterStatus
            switch characterItem.status {
            case .alive:
                characterStatus = .alive
            case .dead:
                characterStatus = .dead
            case .unknown:
                characterStatus = .unknown
            }
            return RickAndMortyCharacter(id: characterItem.id,
                                         name: characterItem.name,
                                         imageURL: imageURL,
                                         gender: gender,
                                         status: characterStatus,
                                         origin: characterItem.origin.name,
                                         location: characterItem.location.name)
        }
    }
}

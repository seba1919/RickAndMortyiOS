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
    
    public typealias Result = CharacterLoader.Result
    
    public init(with url: URL,
                with client: HTTPClient) {
        self.baseURL = url
        self.client = client
    }
    
    public func getAllCharacters(completion: @escaping
        (Result) -> Void) {
        client.get(from: baseURL) { result in
            switch result {
            case let .success((data, response)):
                do {
                    let items = try RickAndMortyItemsMapper.map(data, from: response)
                    completion(.success(items.toModels()))
                }
                catch {
                    completion(.failure(error))
                }
                break
            case .failure:
                completion(.failure(Error.connectivity))
                break
            }
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
                break
            case .male:
                gender = .male
                break
            case .genderless:
                gender = .genderless
                break
            case .unknown:
                gender = .unknown
                break
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
                                         origin: characterItem.origin)
        }
    }
}

//
//  RickAndMortyItemsMapper.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

final class RickAndMortyItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteRickAndMortyCharacterItem]
        
        enum CodingKeys: String, CodingKey {
            case items = "results"
        }
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteRickAndMortyCharacterItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RickAndMortyAPI.Error.invalidData
        }

        return root.items
    }
}

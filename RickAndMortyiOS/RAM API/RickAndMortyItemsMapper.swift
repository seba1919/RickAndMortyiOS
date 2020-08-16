//
//  RickAndMortyItemsMapper.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

final class RickAndMortyItemsMapper {
    struct Root: Decodable {
        let itemsInfo: ItemsInfo
        let items: [RemoteRickAndMortyCharacterItem]
        
        enum CodingKeys: String, CodingKey {
            case items = "results"
            case itemsInfo = "info"
        }
    }
    
    struct ItemsInfo: Decodable {
        let count, pages: Int
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> (characcters: [RemoteRickAndMortyCharacterItem], characctersAmount: Int) {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw LoaderError.invalidData
        }

        return (characcters: root.items, characctersAmount: root.itemsInfo.count)
    }
}

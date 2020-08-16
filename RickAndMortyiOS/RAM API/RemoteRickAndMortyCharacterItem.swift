//
//  RemoteRickAndMortyCharacterItem.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 14/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

public enum RickAndMortyCharacterStatusItem: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

public enum RickAndMortyCharacterGenderItem: String, Decodable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

public struct RickAndMortyLocationItem: Decodable {
    let name: String
    let url: String
}

public struct RemoteRickAndMortyCharacterItem: Decodable {
    public let id: Int
    public let name: String
    public let image: String
    public let gender: RickAndMortyCharacterGenderItem
    public let status: RickAndMortyCharacterStatusItem
    public let origin: RickAndMortyLocationItem
    public let location: RickAndMortyLocationItem
}

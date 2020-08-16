//
//  RickAndMortyCharacter.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 14/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

public enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

public struct Location: Codable {
    let name: String
    let url: String
}

public struct RickAndMortyCharacter: Decodable {
    public let id: Int
    public let name: String
    public let image: String
    public let gender: String
    public let status: Status
    public let origin: Location
}

//
//  RickAndMortyCharacter.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

public enum RickAndMortyCharacterStatus: String {
    case alive
    case dead
    case unknown
}

public enum RickAndMortyCharacterGender: String {
    case female
    case male
    case genderless
    case unknown
}

public struct RickAndMortyCharacter {
    let id: Int
    let name: String
    let imageURL: URL?
    let gender: RickAndMortyCharacterGender
    let status: RickAndMortyCharacterStatus
    let origin: String
    let location: String
}

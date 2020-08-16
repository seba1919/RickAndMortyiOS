//
//  CharacterLoader.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

public enum LoaderError: Swift.Error {
    case connectivity
    case invalidData
}

public protocol CharacterLoader {
    
    typealias Result = Swift.Result<(characters: [RickAndMortyCharacter], charactersAmount: Int), LoaderError>
    
    func getCharacters(forPage pageNumber: Int?, completion: @escaping
                                (Result) -> Void)
}

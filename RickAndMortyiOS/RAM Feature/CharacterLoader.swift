//
//  CharacterLoader.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

public protocol CharacterLoader {
    typealias Result = Swift.Result<[RickAndMortyCharacter], Error>
    
    func getAllCharacters(completion: @escaping ((Result) -> Void))
}

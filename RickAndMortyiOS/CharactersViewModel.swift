//
//  CharactersViewModel.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

class CharactersViewModel {
    let characters = ["test character 1", "test character 2", "test character 3", "test character 4", "test character 5"]
    
    var loadCharacters: (([String]) -> Void)?
}

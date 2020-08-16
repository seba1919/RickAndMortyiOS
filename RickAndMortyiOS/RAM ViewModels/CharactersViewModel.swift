//
//  CharactersViewModel.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

class CharactersViewModel {
    var characters = [RickAndMortyCharacter]()
    
    var loadCharacters: (() -> Void)?
    var loadError: (() -> Void)?
    
    func getAllCharacters() {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let api = RickAndMortyAPI(with: url,
                                  with: URLSessionHTTPClient(session: URLSession.shared))
        api.getAllCharacters { [weak self] result in
            switch result {
            case let .success(characters):
                self?.characters = characters
                self?.loadCharacters?()
                break
            case .failure(_):
                break
            }
        }
        
    }
}

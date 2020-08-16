//
//  CharactersViewModel.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

class CharactersViewModel {
    let api = RickAndMortyAPI(with: URLSessionHTTPClient.shared)
    public var characters = [RickAndMortyCharacter]()
    private var currentPage = 1
    
    public var loadCharacters: (() -> Void)?
    public var loadError: (() -> Void)?
    
    public func loadNextCharactersPage() {
        loadCharacters(forPage: currentPage)
        currentPage += 1
    }
    
    private func loadCharacters(forPage pageNumber: Int) {
            api.getCharacters(forPage: pageNumber) { [weak self] result in
                switch result {
                case let .success(newCharacters):
                    self?.characters.append(contentsOf: newCharacters)
                    self?.loadCharacters?()
                    
                case .failure(_):
                    break
                }
            }
        
    }
}

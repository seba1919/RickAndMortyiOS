//
//  CharactersViewModel.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

class CharactersViewModel {
    public var characters = [RickAndMortyCharacter]()
    private var currentPage = 1
    
    public var loadCharacters: (() -> Void)?
    public var loadError: (() -> Void)?
    
    public func loadNextCharactersPage() {
        loadCharacters(forPage: currentPage)
        currentPage += 1
    }
    
    private func loadCharacters(forPage pageNumber: Int) {
        let api = RickAndMortyAPI(with: URLSessionHTTPClient.shared)
        api.getCharacters(forPage: pageNumber) { [weak self] result in
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

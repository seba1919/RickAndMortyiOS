//
//  CharactersViewModel.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 15/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

class CharactersViewModel {
    // MARK: - Public properties
    public var characters = [RickAndMortyCharacter]()
    public var charactersTotalAmount: Int = 0
    
    // MARK: CharactersViewModel closure handlers
    public var handleCharactersLoaded: (() -> Void)?
    public var handleNoConnectivityError: (() -> Void)?
    public var handleInvalidDataError: (() -> Void)?
    
    
    // MARK: Private properties
    private let characterLoader: CharacterLoader
    private var currentPage = 1
    
    init(with characterLoaderr: CharacterLoader) {
        self.characterLoader = characterLoaderr
    }
    
    // MARK: - Loading characters methods
    public func loadNextCharactersPage() {
        loadCharacters(forPage: currentPage)
        currentPage += 1
    }
    
    private func loadCharacters(forPage pageNumber: Int) {
            characterLoader.getCharacters(forPage: pageNumber) { [weak self] result in
                switch result {
                case let .success((newCharacters, amount)):
                    self?.characters.append(contentsOf: newCharacters)
                    self?.charactersTotalAmount = amount
                    self?.handleCharactersLoaded?()
                    
                case let .failure(error):
                    switch error {
                    case .connectivity:
                        self?.handleNoConnectivityError?()
                    case .invalidData:
                        self?.handleInvalidDataError?()
                    }
                }
            }
    }
}

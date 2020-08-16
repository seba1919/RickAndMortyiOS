//
//  CharacterViewController.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    let character: RickAndMortyCharacter

    init(with characterToBePresented: RickAndMortyCharacter) {
        self.character = characterToBePresented
        super.init(nibName: nil, bundle: nil)
        
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createView() {
        view.backgroundColor = .white
    }
}

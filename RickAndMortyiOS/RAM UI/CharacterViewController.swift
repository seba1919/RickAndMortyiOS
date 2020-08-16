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
    let padding: CGFloat = 8.0
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameWrapper: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(with characterToBePresented: RickAndMortyCharacter) {
        self.character = characterToBePresented
        super.init(nibName: nil, bundle: nil)

        createView()
        view.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        characterImageView.layer.cornerRadius = 0.05*characterImageView.bounds.size.width
    }
    
    func createView() {
        view.backgroundColor = StyleKit.mainColor
        self.title = self.character.name
        
        characterImageView.kf.setImage(with: self.character.imageURL)
        nameLabel.text = self.character.name
        setupLayout()
        
        
    }
    
    func setupLayout() {
        view.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (-1)*padding),
            characterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
        ])
        
        characterImageView.addSubview(nameWrapper)
        NSLayoutConstraint.activate([
            nameWrapper.heightAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 0.24),
            nameWrapper.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            nameWrapper.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            nameWrapper.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameWrapper.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameWrapper.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: nameWrapper.trailingAnchor, constant: (-1)*padding),
            nameLabel.bottomAnchor.constraint(equalTo: nameWrapper.bottomAnchor)
        ])
    }
}

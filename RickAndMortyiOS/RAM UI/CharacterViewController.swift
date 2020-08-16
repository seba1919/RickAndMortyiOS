//
//  CharacterViewController.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    private let character: RickAndMortyCharacter
    private let padding: CGFloat = 8.0
    
    private typealias CharacterDetailInformation = (name: String, value: String)
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = StyleKit.secondaryColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init(with characterToBePresented: RickAndMortyCharacter) {
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
        infoWrapper.layer.cornerRadius = 0.05*characterImageView.bounds.size.width
    }
    
    private func createView() {
        view.backgroundColor = StyleKit.mainColor
        self.title = self.character.name
        
        characterImageView.kf.setImage(with: self.character.imageURL)
        nameLabel.text = self.character.name
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(infoWrapper)
        NSLayoutConstraint.activate([
            infoWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2*padding),
            infoWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            infoWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (-1)*padding)
        ])
        
        infoWrapper.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (-1)*padding),
            characterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
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

        
        let characterDetailInformation: [CharacterDetailInformation] = [
            (name: "Gender:", value: character.gender.rawValue),
            (name: "Status:", value: character.status.rawValue),
            (name: "Origin:", value: character.origin),
            (name: "Location:", value: character.location)]
        
        let detailsInfoView = setupDetailsInfoView(with: characterDetailInformation)
        NSLayoutConstraint.activate([
            detailsInfoView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: padding),
            detailsInfoView.leadingAnchor.constraint(equalTo: nameWrapper.leadingAnchor),
            detailsInfoView.trailingAnchor.constraint(equalTo: nameWrapper.trailingAnchor),
            detailsInfoView.bottomAnchor.constraint(equalTo: infoWrapper.bottomAnchor, constant: 2*(-1)*padding)
        ])
    }
    
    private func setupDetailsInfoView(with characterInformationArray: [CharacterDetailInformation]) -> UIView {
        let informationWrapperView = UIView()
        self.view.addSubview(informationWrapperView)
        informationWrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        var lastConstraint = informationWrapperView.topAnchor
        for characterInformation in characterInformationArray {
            let genderStackView = getDetailInfoStackView(with: characterInformation.name,
                                                         with: characterInformation.value)
            informationWrapperView.addSubview(genderStackView)

            NSLayoutConstraint.activate([
                genderStackView.topAnchor.constraint(equalTo: lastConstraint, constant: padding),
                genderStackView.leadingAnchor.constraint(equalTo: nameWrapper.leadingAnchor, constant: 2*padding),
                genderStackView.trailingAnchor.constraint(equalTo: nameWrapper.trailingAnchor, constant: 4*(-1)*padding),
                genderStackView.heightAnchor.constraint(equalToConstant: 25)
            ])
            
            lastConstraint = genderStackView.bottomAnchor
        }
        informationWrapperView.bottomAnchor.constraint(equalTo: lastConstraint).isActive = true
        
        return informationWrapperView
    }
    
    private func getDetailInfoStackView(with key: String, with value: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let genderKeyLabel = UILabel()
        genderKeyLabel.textColor = .white
        genderKeyLabel.text = key
        
        let genderValueLabel = UILabel()
        genderValueLabel.textColor = .white
        genderValueLabel.text = value
        
        stackView.addArrangedSubview(genderKeyLabel)
        stackView.addArrangedSubview(genderValueLabel)
        
        return stackView
    }
}

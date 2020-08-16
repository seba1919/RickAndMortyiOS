//
//  CharacterTableViewCell.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 16/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var character: RickAndMortyCharacter!
    static let identifier = "CharacterCell"
    
    
    // MARK: UI properties
    let padding: CGFloat = 8.0
    let contentHeight: CGFloat = 80.0
    let cornerRadius: CGFloat = 8.0
    
    // MARK: UI components
    lazy var wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = StyleKit.secondaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var paddingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI setup
    override func layoutSubviews() {
        wrapperView.layer.cornerRadius = cornerRadius
        characterImageView.layer.cornerRadius = cornerRadius
    }
    
    func configureCell(with character: RickAndMortyCharacter) {
        self.character = character
        characterNameLabel.text = character.name
        characterImageView.kf.indicatorType = .activity
        (characterImageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = StyleKit.accentColor
        characterImageView.kf.setImage(with: character.imageURL, options: [
                                        .scaleFactor(UIScreen.main.scale),
                                        .transition(.fade(1)),
                                        .cacheOriginalImage])
    }
    
    private func createView() {
        self.addSubview(wrapperView)
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            wrapperView.heightAnchor.constraint(equalToConstant: contentHeight),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: (-1.5)*padding)
        ])
        
        
        wrapperView.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0.5*padding),
            characterImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: padding),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: contentHeight),
            characterImageView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0.5*(-1)*padding)
        ])
        
        wrapperView.addSubview(characterNameLabel)
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: padding),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: padding),
            characterNameLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -padding),
            characterNameLabel.heightAnchor.constraint(equalToConstant: contentHeight),
            characterNameLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: (-1)*padding)
        ])
    }
}

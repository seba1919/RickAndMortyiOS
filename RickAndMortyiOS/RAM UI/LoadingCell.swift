//
//  LoadingCell.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 17/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import UIKit

public class LoadingCell: UITableViewCell {
    
    // MARK: Static properties
    static let identifier = "LoadingCell"
    
    // MARK: UI components
    lazy var spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    // MARK: Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSpinner()
        self.backgroundColor = StyleKit.mainColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI setup
    private func layoutSpinner() {
        self.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

//
//  CharactersListViewController.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 14/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersListViewController: UIViewController {
    
    var viewModel: CharactersViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = StyleKit.mainColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(with viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.loadCharacters = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.getAllCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyling()
        createView()
    }
    
    func createView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBarStyling() {
        navigationController?.navigationBar.barTintColor = StyleKit.secondaryColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        self.title = "Characters list"
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        
        let character = viewModel.characters[indexPath.row]
        cell.configureCell(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters[indexPath.row]
        let characterPresentingVC =  CharacterViewController(with: selectedCharacter)
        navigationController?.pushViewController(characterPresentingVC, animated: true)
    }
}

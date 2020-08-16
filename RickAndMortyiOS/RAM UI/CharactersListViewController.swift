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
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(with viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViewModel()
        viewModel.loadNextCharactersPage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewModel setup
    fileprivate func setupViewModel() {
        viewModel.handleCharactersLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.handleNoConnectivityError = {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No internet connection", message: "Please, check your internet connection", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        viewModel.handleInvalidDataError = {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Invalid data", message: "Invalid data received, please contact with administrator.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
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
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: StyleKit.accentColor]
        navigationController?.navigationBar.tintColor = StyleKit.accentColor
        self.title = "Characters list"
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.characters.count
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
            if indexPath.row == viewModel.characters.count - 1 {
                //            if totalItems > viewModel.characters.count { // TODO: add fetching total items amount from repsonse
                viewModel.loadNextCharactersPage()
                //            }
            }
            let character = viewModel.characters[indexPath.row]
            cell.configureCell(with: character)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters[indexPath.row]
        let characterPresentingVC =  CharacterViewController(with: selectedCharacter)
        navigationController?.pushViewController(characterPresentingVC, animated: true)
    }
}

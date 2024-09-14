//
//  MovieViewController.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import UIKit

protocol MovieViewInterface: AnyObject {
    func drawView()
}

final class MovieViewController: UIViewController {
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setImage(UIImage(systemName: "house"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        return tableView
    }()
    
    private lazy var viewModel = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.Identifier.custom.rawValue)
        viewModel.viewDidload()
        viewModel.fetchMovie { errorMessage in
            if let errorMessage = errorMessage {
                print(errorMessage)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        bindViewModel()
    }
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                print(errorMessage)
            }
        }
    }
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MovieViewController: MovieViewInterface{
    func drawView() {
        view.backgroundColor = .blue
        view.addSubview(backButton)
        view.addSubview(tableView)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(viewModel.movies)")
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.Identifier.custom.rawValue, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.cellDoldur(title: viewModel.movies[indexPath.row], subTitle: viewModel.moviesYear[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.2
    }
}

//
//  HomeViewController.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 13.09.2024.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureHomePage()
}

final class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    private let goButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setImage(UIImage(systemName: "house"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(goMovieButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.viewDidload()
        viewModel.fetchUniversity { errorMessage in
            if let errorMessage = errorMessage {
                print(errorMessage)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func goMovieButtonTapped() {
        let movieVC = MovieViewController()
        movieVC.modalPresentationStyle = .fullScreen
        present(movieVC, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewInterface {
    func configureHomePage(){
        view.backgroundColor = .red
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            goButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            goButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.universityList.count)
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.cities[indexPath.row]
        return cell
    }
}

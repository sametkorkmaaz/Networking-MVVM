//
//  MovieService.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import Foundation

class MovieService {
    private let apiURL = "https://reactnative.dev/movies.json"
    
    // Fetch the university response including paging data
    func fetchMovies(completion: @escaping (Result<MovieModel, NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(from: apiURL) { (result: Result<MovieModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

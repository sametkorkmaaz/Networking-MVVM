//
//  UniversityService.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import Foundation

class UniversityService {
    private let apiURL = "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/page-1.json"
    
    // Fetch the university response including paging data
    func fetchUniversities(completion: @escaping (Result<UniversityResponse, NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(from: apiURL) { (result: Result<UniversityResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//
//  HomeViewModel.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 13.09.2024.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidload()
    func fetchUniversity(complete: @escaping((String?)->()))
}


final class HomeViewModel {
    weak var view: HomeViewInterface?
    var universityList: [UniversityResponse] = []
    var cities: [String] = []
    var universities: [String] = []
}

extension HomeViewModel: HomeViewModelInterface {

    func viewDidload() {
        view?.configureHomePage()
    }
    
    func fetchUniversity(complete: @escaping((String?)->())){
        // Fetch university data with pagination info
        UniversityService().fetchUniversities { result in
            switch result {
            case .success(let response):
                for province in response.data {
                    self.cities.append(province.province)
                 //   print("Province: \(province.province)")
                    for university in province.universities {
                        self.universities.append(university.name)
                       // print("University: \(university.name)")
                    }
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

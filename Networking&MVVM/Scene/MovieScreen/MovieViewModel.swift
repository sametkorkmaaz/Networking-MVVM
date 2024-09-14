//
//  MovieViewModel.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import Foundation

protocol MovieViewModelInterface{
    var view: MovieViewInterface? { get set }
    
    func viewDidload()
    func fetchMovie(complete: @escaping((String?)->()))
}

final class MovieViewModel {
    weak var view: MovieViewInterface?
    var movies : [String] = []
    var moviesYear : [String] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
}

extension MovieViewModel: MovieViewModelInterface{
    
    func viewDidload() {
        view?.drawView()
    }
    
    func fetchMovie(complete: @escaping ((String?) -> ())) {
        MovieService().fetchMovies { result in
            switch result {
            case .success(let response):
                for i in response.movies! {
                    self.movies.append(i.title!)
                    self.moviesYear.append(i.releaseYear!)
                    self.onDataUpdated?()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}

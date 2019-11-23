//
//  MoviePresenter.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit

class MoviePresenter {
    var moviesPopular: Array<Movie> = []
    var moviesFavorites: Array<Movie> = []
    
   /* func fetchMovies() {
        let callback = {(_ movies: Array<Movie>?, _ error: Error?) -> Void in
            if let movies = movies {
                self.moviesFavorites = movies
                self.tableView.reloadData()
                let cbFavorite = {(_ favorite: Bool) -> in
                    
                }
                for movie in self.movies {
                    MovieService.isFavorite(movie)
                }
                //self.progress.stopAnimating()
            } else if let error = error {
                Util.alerta("Erro: " + error.localizedDescription, viewController: self)
            }
        }
        MovieService.getMoviesFavorites(callback)
    }*/
}

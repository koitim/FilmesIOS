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
    
    let view: MovieView
    
    init(view: MovieView) {
        self.view = view
    }
    
    func getMoviesPopular() -> Array<Movie> {
        return moviesPopular
    }
    
    func getMoviesFavorite() -> Array<Movie> {
        return moviesFavorites
    }
    
    func fetchMovies() {
        let cbFavorites = {(_ movies: Array<Movie>?, _ error: Error?) -> Void in
            if let movies = movies {
                self.moviesFavorites = movies
                self.view.updatedFavorites()
            }
        }
        MovieService.getMoviesFavorites(cbFavorites)
        
        let cbPopular = {(_ movies: Array<Movie>?, _ error: Error?) -> Void in
            if let movies = movies {
                self.moviesPopular = movies
                self.view.updatedPopular()
            }
        }
        MovieService.getMoviesPopular(cbPopular)
    }
    
    func favorite(_ movie: Movie) {
        MovieService.favorite(movie)
        moviesFavorites.append(movie)
        view.updatedFavorites()
    }
    
    func unFavorite(_ movie: Movie) {
        MovieService.unFavorite(movie)
        moviesFavorites = moviesFavorites.filter { (m) -> Bool in
            movie.id != m.id
        }
        view.updatedFavorites()
    }
}

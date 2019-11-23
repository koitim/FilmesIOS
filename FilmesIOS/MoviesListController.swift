//
//  MoviesListController.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListController: UIViewController, UITableViewDataSource, UITableViewDelegate, MovieView {
    
    @IBOutlet var tableView: UITableView!
    //@IBOutlet var progress: UIActivityIndicatorView!
    
    let POPULAR_MOVIE_LISTING = 0
    let FAVORITE_MOVIE_LISTING = 1
    var currentListing: Int = 0
    var movies: Array<Movie> = []
    var presenter: MoviePresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MoviePresenter(view: (self as? MovieView)!)
        self.title = "Filmes"
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.currentListing = POPULAR_MOVIE_LISTING
        presenter!.fetchMovies()
        self.movies = presenter!.getMoviesPopular()
    }
    
    func updatedPopular() {
        if currentListing == POPULAR_MOVIE_LISTING {
            movies = presenter!.getMoviesPopular()
            self.tableView.reloadData()
        }
    }
    
    func updatedFavorites() {
        if currentListing == FAVORITE_MOVIE_LISTING {
            movies = presenter!.getMoviesFavorite()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.movies[indexPath.row]
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as? MovieCell {
            cell.lblTitleMovie.text = movie.title
            let url = "https://image.tmdb.org/t/p/w154" + movie.url_image
            cell.imgMovie.sd_setImage(with: URL(string: url))
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        if idx == 0 {
            currentListing = POPULAR_MOVIE_LISTING
            self.movies = presenter!.getMoviesPopular()
        } else {
            currentListing = FAVORITE_MOVIE_LISTING
            self.movies = presenter!.getMoviesFavorite()
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailMovie" {
            if let vc = segue.destination as? MovieShowController {
                vc.movie = sender as? Movie
                vc.presenter = presenter!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linha = indexPath.row
        let movie = self.movies[linha]
        if currentListing == POPULAR_MOVIE_LISTING {
            movie.favorite = presenter!.getMoviesFavorite().contains { movieList in
                return movieList.id == movie.id
            }
        }
        performSegue(withIdentifier: "goToDetailMovie", sender: movie)
    }
}










































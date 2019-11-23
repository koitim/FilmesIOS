//
//  MoviesListController.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var movies: Array<Movie> = []
    //@IBOutlet var progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.clearsSelectionOnViewWillAppear = false
        //self.movies = MovieService.getMovies()
        self.title = "Filmes"
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        /*
        //let xib = UINib(nibName: "MovieCell", bundle: nil)
        */
        listMovies("populares")
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
            listMovies("populares")
        } else {
            listMovies("favoritos")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailMovie" {
            if let vc = segue.destination as? MovieShowController {
                vc.movie = sender as? Movie
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linha = indexPath.row
        let movie = self.movies[linha]
        performSegue(withIdentifier: "goToDetailMovie", sender: movie)
    }
    
    func listMovies(_ type: String) {
        //progress.startAnimating()
        let callback = {(_ movies: Array<Movie>?, _ error: Error?) -> Void in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                //self.progress.stopAnimating()
            } else if let error = error {
                Util.alerta("Erro: " + error.localizedDescription, viewController: self)
            }
        }
        if type == "populares" {
            MovieService.getMoviesPopular(callback)
        } else {
            MovieService.getMoviesFavorites(callback)
        }
    }
}


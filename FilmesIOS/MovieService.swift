//
//  MovieService.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class MovieService {
    class func getMoviesPopular(_ callback: @escaping (_ movies: Array<Movie>?, _ error: Error?) -> Void) {
        let http = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=942ccf9bf53c7651369a6116da7ed318&language=pt-BR")
        let request = URLRequest(url: url!)
        let task = http.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                callback(nil, error)
                return
            }
            if let data = data {
                let movies = MovieService.parserJson(data)
                DispatchQueue.main.async {
                    callback(movies, nil)
                }
            }
        })
        task.resume()
    }
    
    class func getMoviesFavorites(_ callback: @escaping (_ movies: Array<Movie>?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("favoritos").child(currentUser!.uid).observeSingleEvent(of: .value, with: {(snapshot) in
            var movies: Array<Movie> = []
            for child in snapshot.children {
                let data = child as! DataSnapshot
                let dataValue = data.value as! [String: AnyObject]
                let movie = Movie()
                movie.id = dataValue["id"] as! Int
                movie.title = dataValue["titulo"] as! String
                movie.url_image = dataValue["imagem"] as! String
                movie.synopsis = dataValue["sinopse"] as! String
                movie.favorite = true
                movies.append(movie)
            }
            DispatchQueue.main.async {
                callback(movies, nil)
            }
        }) {(error) in
            callback(nil, error)
        }
    }
    
    class func isFavorite(_ movie: Movie) -> Bool {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("favoritos").child(currentUser!.uid).child(String(movie.id)).observeSingleEvent(of: .value, with: {(snapshot) in
           
        }) {(error) in
            return false
        }
        return true
    }
    
    class func parserJson(_ data: Data) -> Array<Movie> {
        var movies: Array<Movie> = []
        do {
            let dictResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            let arrayMovies = dictResponse["results"] as! NSArray
            for obj in arrayMovies {
                let dict = obj as! NSDictionary
                let movie = Movie()
                movie.id = dict["id"] as! Int
                movie.title = getValue("title", dict)
                movie.synopsis = getValue("overview", dict)
                movie.url_image = getValue("poster_path", dict)
                movies.append(movie)
            }
        } catch let error as NSError {
            print("Erro ao ler JSON (error)")
        }
        return movies
    }
    
    class func getValue(_ key: String, _ dict: NSDictionary) -> String {
        let s = dict[key]
        if let s = s {
            return s as! String
        }
        return ""
    }
}



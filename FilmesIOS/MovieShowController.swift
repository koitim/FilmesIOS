//
//  MovieShowController.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit

class MovieShowController: UIViewController {
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var snpss: UITextView!
    @IBOutlet var btnFavorite: UIButton!
    
    var movie: Movie?
    var presenter: MoviePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            self.title = movie.title
            self.snpss.text = movie.synopsis
            let url = "https://image.tmdb.org/t/p/w154" + movie.url_image
            self.img.sd_setImage(with: URL(string: url))
            if movie.favorite {
                btnFavorite.setTitle("Desfavoritar", for: .normal)
            } else {
                btnFavorite.setTitle("Favoritar", for: .normal)
            }
        }
    }
    
    @IBAction func onClickFavorite(_ sender: UIButton) {
        if movie!.favorite {
            btnFavorite.setTitle("Desfavoritar", for: .normal)
        } else {
            btnFavorite.setTitle("Favoritar", for: .normal)
        }
        if movie!.favorite {
            presenter!.unFavorite(movie!)
        } else {
            presenter!.favorite(movie!)
        }
    }
}

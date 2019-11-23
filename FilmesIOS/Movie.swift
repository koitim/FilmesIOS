//
//  Movie.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit

class Movie {
    var id = 0
    var title = " "
    var synopsis = " "
    var url_image = " "
    var favorite = false
    
    func cloneFirebase() -> MovieFirebase {
        let mf = MovieFirebase()
        mf.id = self.id
        mf.title = self.title
        mf.synopsis = self.synopsis
        mf.url_image = self.url_image
        return mf
    }
}

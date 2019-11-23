//
//  String+Extensions.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
    func replace(_ of: String, with: String) -> String {
        let s = self.replacingOccurrences(of: of, with: with)
        return s
    }
    func url() -> URL {
        return URL(string: self)!
    }
    func count() -> Int {
        return self.characters.count
    }
}

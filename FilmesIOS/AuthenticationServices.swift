//
//  AuthenticationServices.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationServices {
    
    class func signIn(email: String, pass: String, callback: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error /*, let _ = AuthErrorCode(rawValue: error._code)*/ {
                let aec = AuthErrorCode(rawValue: error._code)
                let tx2 = aec.debugDescription
                
                callback(false)
            } else {
                callback(true)
            }
        }
    }
    
    
    class func createUser(email: String, password: String, callback: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let error = error {
                callback(false)
            } else {
                callback(true)
            }
        }
    }
}

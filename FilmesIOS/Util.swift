//
//  Util.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit

class Util {
    class func alerta(_ msg: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showError(_ msg: String, viewController: UIViewController) {
        let error = UIAlertController(title: "Erro", message: msg, preferredStyle: UIAlertControllerStyle.actionSheet)
        error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
        viewController.present(error, animated: true, completion: nil)
    }
    
    func showPopup(isSuccess: Bool, viewController: UIViewController) {
        let successMessage = "User was sucessfully logged in."
        let errorMessage = "Algum erro aconteceu. Por favor tente novamente"
        let alert = UIAlertController(title: isSuccess ? "Sucesso": "Erro", message: isSuccess ? successMessage: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

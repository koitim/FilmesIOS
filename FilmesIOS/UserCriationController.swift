//
//  UserCriationController.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserCriationController: UIViewController {
    
    @IBOutlet weak var email               : UITextField!
    @IBOutlet weak var password            : UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onClickCreate(_ sender: UIButton) {
        let isValidEmail = AuthenticationPresenter.isValid(email: email.text!)
        if isValidEmail {
            let isValidPassword = AuthenticationPresenter.isValid(password: password.text!)
            if isValidPassword && password.text! == passwordConfirmation.text! {
                let callback = {(_ success: Bool) -> Void in
                    if success {
                        Util.alerta("Usuário criado com sucesso", viewController: self)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        Util.showError("Não foi possível criar o usuário", viewController: self)
                    }
                }
                AuthenticationServices.createUser(email: email.text!, password: password.text!, callback: callback)
                
            
            }
        }
    }
}

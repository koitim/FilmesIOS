//
//  PasswordRecoveryController.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordRecoveryController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onClickRecovery(_ sender: UIButton) {
        let isValidEmail = AuthenticationPresenter.isValid(email: email.text!)
        if isValidEmail {
            /*Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
             if error != nil {
             print("erro:")
             Util.showError("Não foi possível criar o usuário", viewController: self)
             } else {
             print("OK")
             Util.alerta("Usuário criado com sucesso", viewController: self)
             self.navigationController?.popViewController(animated: true)
             }
             }*/
        }
    }
    
}

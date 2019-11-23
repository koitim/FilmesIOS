//
//  ViewController.swift
//  FilmesIOS
//
//  Created by posgrad on 23/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var email   : UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        let isValidEmail = AuthenticationPresenter.isValid(email: email.text!)
        if isValidEmail {
            let isValidPassword = AuthenticationPresenter.isValid(password: password.text!)
            if isValidPassword {
                
                let callback = {(_ success: Bool/*, _ error: Error?*/) -> Void in
                    if success {
                        if let initialVC = UIStoryboard(name: "Movies", bundle: nil).instantiateInitialViewController() {
                            self.present(initialVC, animated: true, completion: nil)
                        }
                    } else {
                        Util.alerta("Ocorreu algum erro", viewController: self)
                    }
                }
                AuthenticationServices.signIn(email: email.text!, pass: password.text!, callback: callback)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        /*handle = Auth.auth().addStateDidChangeListener { (auth, user) in
         // ...
         }*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Auth.auth().removeStateDidChangeListener(handle!)
    }
    
}

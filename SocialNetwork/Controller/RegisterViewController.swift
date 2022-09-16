//
//  RegisterViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundTextField(name: emailTextField)
        roundTextField(name: passwordTextField)
        

    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
        
            Auth.auth().createUser(withEmail: email , password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }else {
                    print("user uspesno kreiran!")
                    self.performSegue(withIdentifier:K.segueToSocialNetwork, sender: self)
                }
                
            
            }
        }
        
    }
    
    
}


extension UIViewController {
    func roundTextField(name textFieldName:UITextField) {
        textFieldName.layer.cornerRadius = 15.0
        textFieldName.layer.borderWidth = 2.0
        textFieldName.layer.borderColor = UIColor.black.cgColor
        textFieldName.clipsToBounds = true
    }
}

//
//  RegisterViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundUIElement(name: emailTextField)
        roundUIElement(name: passwordTextField)
        roundUIElement(name: signUpButton)
        
    }
    
    // kada se registrira korisnik, treba odma kreirati model u bazi koji ce imati njegov uid, bio, email, username,
    // kada je kreiran nalog, followers, following to ce biti nizovi koji ce imati u sebi druge uid tj uid od drugih
    // korisnika
    
    //TODO: proveriti i username da li postoji
    
    
    
    @IBAction func signUp(_ sender: UIButton) {
        
    
        if let email = emailTextField.text, let password = passwordTextField.text {
        
        
            Auth.auth().createUser(withEmail: email , password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    
                }else {
                    
                        let currUser = Auth.auth().currentUser!
                        self.db.collection("users").document(currUser.uid).setData([
                            "created":FieldValue.serverTimestamp(),
                            "bio":"Default bio",
                            "email":currUser.email!,
                            "username":currUser.email!.components(separatedBy: "@")[0],
                            "uid":currUser.uid,
                            "followers":[],
                            "following":[]
                        ])
                        
                        self.performSegue(withIdentifier:K.segueToSocialNetwork, sender: self)
                
                }
                
            }
        }
        
    }
    
     
    
    
}


extension UIViewController {
    func roundUIElement(name elementName:UITextField) {
        elementName.layer.cornerRadius = 15.0
        elementName.layer.borderWidth = 2.0
        elementName.layer.borderColor = UIColor.clear.cgColor
        elementName.clipsToBounds = true
    }
    
    func roundUIElement(name elementName:UIButton) {
        elementName.layer.cornerRadius = 15.0
        elementName.layer.borderWidth = 2.0
        elementName.layer.borderColor = UIColor.clear.cgColor
        elementName.clipsToBounds = true
    }
}

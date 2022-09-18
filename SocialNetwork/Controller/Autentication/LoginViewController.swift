//
//  LoginViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundUIElement(name: emailTextField)
        roundUIElement(name: passwordTextField)
        roundUIElement(name: signInButton)
        
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
        
            Auth.auth().signIn(withEmail: email , password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    self.errorLabel.text = e.localizedDescription
                }else {
                    let currUser = Auth.auth().currentUser!
                    print(currUser.uid)
                    print("user uspesno prijavljen!")
                                        
                    
                    self.performSegue(withIdentifier:K.segueToSocialNetwork, sender: self)
                }
                
            
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

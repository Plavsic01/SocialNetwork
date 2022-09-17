//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit
import CLTypingLabel


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating animation for title
        
        roundUIElement(name:signInButton)
        roundUIElement(name:signUpButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = "SocialNetwork"
    }

}


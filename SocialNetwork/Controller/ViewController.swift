//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit
import CLTypingLabel


class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating animation for title
        titleLabel.text = "SocialNetwork"
    }


}


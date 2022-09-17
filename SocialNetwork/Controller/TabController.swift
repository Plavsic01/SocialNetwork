//
//  TabController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }


}

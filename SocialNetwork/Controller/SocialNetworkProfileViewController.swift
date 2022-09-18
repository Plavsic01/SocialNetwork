//
//  SocialNetworkProfileViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import UIKit

class SocialNetworkProfileViewController: UIViewController {

    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        userManager.getCurrentUserData()
    }
 

}


extension SocialNetworkProfileViewController: UserManagerDelegate {
    
    func didUpdateUserProfile(_ userManager: UserManager, user: User) {
        print(user.email)
        print(user.uid)
        print(user.created)
    }
    
    
    
}

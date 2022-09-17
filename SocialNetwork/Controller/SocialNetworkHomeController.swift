//
//  SocialNetworkPageController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit


class SocialNetworkHomeController: UIViewController {

    
    
    var userManager = UserManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        
        userManager.getCurrentUserData()
        
    }


}


extension SocialNetworkHomeController: UserManagerDelegate {
    
    func didUpdateUserProfile(_ userManager: UserManager, user: User) {
        print(user.email)
        print(user.uid)
        print(user.created)
    }
    
    
    
}

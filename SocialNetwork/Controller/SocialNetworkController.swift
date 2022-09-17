//
//  SocialNetworkPageController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit


class SocialNetworkController: UIViewController {

    
    
    var userManager = UserManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        
        userManager.getCurrentUserData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
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


extension SocialNetworkController: UserManagerDelegate {
    
    func didUpdateUserProfile(_ userManager: UserManager, user: User) {
        print(user.email)
        print(user.uid)
        print(user.created)
    }
    
    
    
}

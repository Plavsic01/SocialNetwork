//
//  SocialNetworkProfileViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import UIKit

class SocialNetworkProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var images = [
        
    ["square.and.arrow.up","square.and.arrow.up","square.and.arrow.up"], //prvi red
    ["square.and.arrow.up.fill","square.and.arrow.up.fill","square.and.arrow.up.fill"], // drugi red

]
    
    
    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        tableView.dataSource = self
        userManager.getCurrentUserData()
    }
 

}


extension SocialNetworkProfileViewController: UserManagerDelegate,UITableViewDataSource,UITableViewDelegate{
    
    
    
    
    func didUpdateUserProfile(_ userManager: UserManager, user: User) {
        print(user.email)
        print(user.uid)
        print(user.created)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PhotosProfile
        cell.firstImage.image = UIImage(systemName: images[indexPath.row][0])
        cell.secondImage.image = UIImage(systemName: images[indexPath.row][1])
        cell.thirdImage.image = UIImage(systemName: images[indexPath.row][2])
        
        return cell
    
        
    }
    
    
}




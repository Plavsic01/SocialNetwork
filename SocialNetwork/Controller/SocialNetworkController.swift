//
//  SocialNetworkPageController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 16.9.22..
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SocialNetworkController: UIViewController {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func getCurrentUserData(){
        let currUser = Auth.auth().currentUser!
        let docRef = db.collection("users").document(currUser.uid)
        docRef.getDocument { document, error in
            if let document = document,document.exists {
                let dataDescription = document.data()!
                print("\(dataDescription["uid"]!)")
            }else{
                print("document does not exist")
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

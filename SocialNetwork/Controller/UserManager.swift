//
//  UserManager.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserManagerDelegate {
    func didUpdateUserProfile(_ userManager:UserManager,user:User)
}

struct UserManager {
    
    var delegate:UserManagerDelegate?
    
    
    func getCurrentUserData(){
        
        let db = Firestore.firestore()
        
        let currUser = Auth.auth().currentUser!
        let docRef = db.collection("users").document(currUser.uid)
        docRef.getDocument { document, error in
            
            if let document = document,document.exists {
                let dataDescription = document.data()!
            
                let dateUnix = dataDescription["created"]! as! Timestamp
                let date = Date(timeIntervalSince1970: Double(dateUnix.seconds))
                
                let username = dataDescription["username"] as! String
                let uid = currUser.uid
                let email = currUser.email!
                let created = convertDateTimeZone(date: date)
                let bio = dataDescription["bio"] as! String
                let followers = dataDescription["followers"] as! [String]
                let following = dataDescription["following"] as! [String]
            
                let currUser = User(username: username, uid: uid, email: email, created: created, bio: bio, followers: followers, following: following)
                
                delegate?.didUpdateUserProfile(self, user: currUser)
                
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    
    
    func convertDateTimeZone(date:Date) -> String{
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = format.string(from: date)
        return dateString

    }

    
    
}

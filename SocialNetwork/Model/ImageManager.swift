//
//  ImageManager.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 18.9.22..
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


struct ImageManager {
    
    
    
    func uploadImage(img:UIImage) {
        
        // current user
        let currUser = Auth.auth().currentUser!
        
        // storage reference
        let storageRef = Storage.storage().reference()
        
        // image Data type with 0.8 jpeg compression quality
        let imageData = img.jpegData(compressionQuality: 0.8)
        
        if let safeImageData = imageData {
            
            
            // image path for creating url of path in firestore db
            let path = "images/\(currUser.uid)/\(UUID().uuidString).jpg"
            
            // where to put image in firebase storage
            let fileRef = storageRef.child(path)
            
            
            
            // upload image data and write url path to firestore db
            let _ = fileRef.putData(safeImageData) { metadata, error in
                if error == nil && metadata != nil {
                    let db = Firestore.firestore()
                    db.collection("users").document(currUser.uid).collection("images").document().setData(["url":path])
                    downloadImage()
                }
            }
        }
        
    }
    
    
    func downloadImage() {
        
        
        let db = Firestore.firestore()

        let currUser = Auth.auth().currentUser!
        
        // get all url paths of photos
        
        var paths = [String]() // initialize emtpy array of Strings
        
        let _ = db.collection("users").document(currUser.uid).collection("images").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
    
                for data in snapshot!.documents{
                    paths.append(data["url"] as! String)
                }
        }
            
        }
    }
    
    
}

//
//  ImageManager.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 18.9.22..
//
//
import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit
//
//
//
struct ImageManager {
    
    
    
    static func uploadImageGetURL(image:UIImage) {
        
        let currUser = Auth.auth().currentUser!
        let path = "images/\(currUser.uid)/\(UUID().uuidString).jpg"
        
        let data = image.jpegData(compressionQuality: 0.1)!

        let storageRef = Storage.storage().reference(withPath:path)
        
        storageRef.putData(data) {_, error in
            
            if let error = error {
                print("Failed \(error.localizedDescription)")
            }
            
            storageRef.downloadURL { url, error in
                
                if error == nil && url != nil {
                    let db = Firestore.firestore()
                    db.collection("users").document(currUser.uid).collection("images").document().setData(["url":url!.absoluteString])
                } else {
                    
                    print(error!.localizedDescription)
                    
                }

            }
            
        }
        
        
        
    }
    
    
    
    
//
//    let cache = NSCache<NSString,UIImage>()
//
//    func uploadImage(img:UIImage) {
//
//        // current user
//        let currUser = Auth.auth().currentUser!
//
//        // storage reference
//        let storageRef = Storage.storage().reference()
//
//        // image Data type with 0.8 jpeg compression quality
//        let imageData = img.jpegData(compressionQuality: 0.0)
//
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//
//        if let safeImageData = imageData {
//
//
//            // image path for creating url of path in firestore db
//            let path = "images/\(currUser.uid)/\(UUID().uuidString).jpg"
//
//            // where to put image in firebase storage
//            let fileRef = storageRef.child(path)
//
//
//
//            // upload image data and write url path to firestore db
//            let _ = fileRef.putData(safeImageData,metadata: metadata) { metadata, error in
//                if error == nil && metadata != nil {
//                    let db = Firestore.firestore()
//                    db.collection("users").document(currUser.uid).collection("images").document().setData(["url":path])
//
//                }
//            }
//
//        }
//
//    }
//
//
//
//    func downloadImage(completionHandler:@escaping(UIImage) -> Void){
//
//
//
//        let db = Firestore.firestore()
//
//        let currUser = Auth.auth().currentUser!
//
//
//        let _ = db.collection("users").document(currUser.uid).collection("images").getDocuments { snapshot, error in
//            if error == nil && snapshot != nil {
//
//                for data in snapshot!.documents{
//
//
//                    let url = data["url"] as! String
//
//
//                    if let cachedImg = cache.object(forKey: NSString(string: url)) {
//
//                        print("KORISTI SE KESIRANA SLIKA")
//
//                        DispatchQueue.main.async {
//                            completionHandler(cachedImg)
//                        }
//
//
//                    } else {
//
//                        let storageRef = Storage.storage().reference(withPath: url)
//
//
//                        storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//
//                            if error == nil && data != nil {
//
//
//                                let img = UIImage(data: data!)!
//
//                                cache.setObject(img, forKey: NSString(string: url))
//
//                                print("KORISTI SE NEEE KESIRANA SLIKA")
//
//                                DispatchQueue.main.async {
//                                    completionHandler(img)
//
//                                }
//
//
//
//                            }
//
//
//                        }
//                    }
//
//
//
//
//                }
//
//             }
//
//
//        }
//
//    }
//
//
//
//
//
    }
//

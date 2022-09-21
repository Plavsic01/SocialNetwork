//
//  SocialNetworkProfileViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class SocialNetworkProfileViewController: UIViewController{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var images:[String] = []
    
    var userManager = UserManager()
    var imagePicker = UIImagePickerController()
    

    
    override func viewWillAppear(_ animated: Bool) {
        userManager.getCurrentUserData()
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        imagePicker.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        addDatabaseListener()

    }
    
    func addDatabaseListener() {
        let currUser = Auth.auth().currentUser!
        let databaseRef = Firestore.firestore()
        databaseRef.collection("users").document(currUser.uid).collection("images").addSnapshotListener { querySnapshot, error in

            self.images.removeAll()
            
            
            if let documents = querySnapshot?.documents {
                
                for document in documents {
                    self.images.append(document.data()["url"] as! String)
                    self.collectionView.reloadData()
                }
                
            }
            
        }
            
        }
    
    
 
    @IBAction func uploadImage(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker,animated: true,completion: nil)
        
        
    }
    
}


extension SocialNetworkProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,
                                             UserManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    
    func didUpdateUserProfile(_ userManager: UserManager, user: User) {
        print(user.email)
        print(user.uid)
        print(user.created)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

   
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:K.cellIdentifier, for: indexPath) as! CollectionViewCell
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: self.images[indexPath.row])!)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    
   
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            //            imageView.contentMode = .scaleAspectFit
            //            imageView.image = pickedImage
            
            ImageManager.uploadImageGetURL(image: pickedImage)
            
            


            

        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
    
}


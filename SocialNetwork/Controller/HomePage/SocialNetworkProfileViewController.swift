//
//  SocialNetworkProfileViewController.swift
//  SocialNetwork
//
//  Created by Andrej Plavsic on 17.9.22..
//

import UIKit

class SocialNetworkProfileViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagesFromStorage = [
        "square.and.arrow.up","square.and.arrow.up","square.and.arrow.up",  "square.and.arrow.up.fill","square.and.arrow.up.fill","square.and.arrow.up.fill"
    ]
    
    var userManager = UserManager()
    var imageManager = ImageManager()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.delegate = self
        imagePicker.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        userManager.getCurrentUserData()
    }
    
 
    @IBAction func uploadImage(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker,animated: true,completion: nil)
        
    }
    
}


extension SocialNetworkProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,UserManagerDelegate,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func didUpdateUserProfile(_ userManager: UserManager, user: User) {
        print(user.email)
        print(user.uid)
        print(user.created)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesFromStorage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:K.cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(systemName: imagesFromStorage[indexPath.row])
        return cell
    }
    
    
   
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageManager.uploadImage(img: pickedImage)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
    
}




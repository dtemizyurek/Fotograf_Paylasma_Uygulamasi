//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Doğukan Temizyürek on 20.07.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func chooseImage()
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func uploadButtonTiklandi(_ sender: Any)
    {
        let storage = Storage.storage()
        
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5)
        {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            

            imageReference.putData(data) { (stroagemetadata, error) in
                if error != nil
                {
                    self.showErrorMessage(title: "Hata", message: error?.localizedDescription ?? "Hata aldınız , Tekrar deneyiniz")
                    
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil
                        {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl
                            {
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["gorselurl" : imageUrl, "yorum": self.textField.text!, "email" : Auth.auth().currentUser!.email, "tarih" : FieldValue.serverTimestamp()] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost)
                                {
                                   (error) in
                                    if error != nil
                                    {
                                        self.showErrorMessage(title: "Hata", message: error?.localizedDescription ?? "Hata aldınız , Tekrar deneyiniz ")
                                    }else
                                    {
                                        self.imageView.image=UIImage(named: "gorselsec")
                                        self.textField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                                
                                
                            }
                            
                            
                        }
                    }
                }
            }
            
        }

        
    }
    
    func showErrorMessage(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

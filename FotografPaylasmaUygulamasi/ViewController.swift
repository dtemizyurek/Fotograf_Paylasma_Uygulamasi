//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Doğukan Temizyürek on 20.07.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sifreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any)
    {
        if emailTextField.text != "" && sifreTextField.text != ""
        {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil
                {
                    self.errorMessage(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata aldınız, tekrar deneyin")
                }
                else
                {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else
        {
            self.errorMessage(titleInput: "Hata", messageInput: "Email ve Parola giriniz !")

        }
        
        
    }
    @IBAction func kayitOlTiklandi(_ sender: Any)
    {
        if emailTextField.text != "" && sifreTextField.text != ""
        {
            //kayıt olma işlemi
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil
                {
                    self.errorMessage(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyin")
                }
                else
                {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else
        {
            errorMessage(titleInput: "Hata !", messageInput: "Email ve şifre giriniz")
        }
    }
    func errorMessage(titleInput : String , messageInput: String)
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Doğukan Temizyürek on 20.07.2023.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func cikisYapTiklandi(_ sender: Any)
    {
        do
        {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch
        {
            print("hata")
        }
        
       
        
        performSegue(withIdentifier: "toViewController", sender: nil)
        
    }
    
    

}

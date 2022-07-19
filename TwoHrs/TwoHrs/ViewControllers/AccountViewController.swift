//
//  AccountViewController.swift
//  TwoHrs
//
//  Created by Apple on 24/06/22.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
   
    @IBOutlet weak var btnLogOut: UIButton!
    
    
    override func viewDidLoad() {
      
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "Logout", message: "Do you want to Logout ?", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

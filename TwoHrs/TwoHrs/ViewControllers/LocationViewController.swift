//
//  LocationViewController.swift
//  TwoHrs
//
//  Created by Apple on 28/06/22.
//

import UIKit

class LocationViewController: BaseViewController {

    @IBOutlet weak var txtSelectCity: UITextField!
    @IBOutlet weak var txtEnterPin: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSelectCity.layer.cornerRadius = 15
        txtSelectCity.layer.borderColor = UIColor.orange.cgColor
        txtSelectCity.layer.borderWidth = 1

        txtEnterPin.layer.cornerRadius = 15
        txtEnterPin.layer.borderColor = UIColor.orange.cgColor
        txtEnterPin.layer.borderWidth = 1

        btnSubmit.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSubmitLocation(_ sender: Any) {
        doSaveLocationDetails()
    }
}

extension LocationViewController {
   func doSaveLocationDetails () {
       let parameters: [String: Any] = ["state_id": "22"]
       print(parameters)
     
                                    
       fetchOrSendWithHeaderData(url: Urls.getCities, Parameter: parameters) { result, success, message in
           if success {
               if result ["success"] as! Int == 1 {
                   print("Success message")
                   let data = result ["data"] as! [AnyObject]
                  
                   let objectFirst = data[0]
                   print("first ", objectFirst)
//                   let cityId = data["id"] as? Any
//                   let stateId = data["state_id"] as? AnyObject
//                   let userPin = self.txtEnterPin.text
                   
                                
//                   UserDefaults.standard.set(cityId, forKey: userData.cityID)
//                   UserDefaults.standard.set(cityName, forKey: userData.cityName)
//                   UserDefaults.standard.set(stateId, forKey: userData.stateID)
//                   UserDefaults.standard.set(userPin, forKey: userData.userPin)
//
//                   self.performSegue(withIdentifier: "seguefrmLocationToDash", sender: nil)
                   
                   
               } else if result ["success"] as! Int == 0 {
                   print("Invalid OTP")
                   
               } else {
                   print("Result message")
               }
               
           } else {print("Network error")}
       }
       
        
    }
}

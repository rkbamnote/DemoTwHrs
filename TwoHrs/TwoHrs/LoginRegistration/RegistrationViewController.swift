//
//  RegistrationViewController.swift
//  TwoHrs
//
//  Created by Apple on 25/06/22.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    @IBOutlet weak var txtNameReg: UITextField!
    @IBOutlet weak var txtAddressReg: UITextField!
    @IBOutlet weak var txtPhoneReg: UITextField!
    @IBOutlet weak var txtEmailReg: UITextField!
    @IBOutlet weak var txtRefCodeReg: UITextField!
    @IBOutlet weak var imgBAck: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgBAck.isUserInteractionEnabled = true
        imgBAck.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.dismiss(animated: true)
    }
    
    @IBAction func btnRegAtReg(_ sender: Any) {
        let name = txtNameReg.text, email = txtEmailReg.text, mobile = txtPhoneReg.text,
            refCode = txtRefCodeReg.text, address = txtAddressReg.text
        
        if ((name!).trimmingCharacters(in: .whitespaces).isEmpty) {
            print("Please enter name")
        } else if ((email!).trimmingCharacters(in: .whitespaces).isEmpty) {
            print("Please enter email")
        } else if (!self.validateEmailId(emailID: email!)){
            print("Please enter valid email")
        } else if ((mobile!).trimmingCharacters(in: .whitespaces).isEmpty) {
            print("Please enter mobile")
        } else if (!self.validaPhoneNumber(phoneNumber: mobile!)) {
            print("Please enter valid mobile")
            
        } else if ((address!).trimmingCharacters(in: .whitespaces).isEmpty) {
            print("Please enter address")
        } else {
            self.doRegistration()
        }
    }
    
    @IBAction func btnLoginAtReg(_ sender: Any) {
        dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegistrationViewController {
    func doRegistration(){
        let parameters: [String: Any] = [
            "name": txtNameReg.text as Any,
            "email": txtEmailReg.text as Any,
            "address": txtAddressReg.text as Any,
            "mobile": txtPhoneReg.text as Any,
            "refer_by_id": txtRefCodeReg.text as Any ]
        
//        let parameters: [String: Any] = [ "name": "sss",
//        "email": "shahnawazhasan03@gmail.com",
//        "address":"ass",
//        "mobile":"7588742940",
//        "refer_by_id":"" ]
        print(parameters)
        
        fetchOrSendWithHeaderData(url: "https://2hrs.in/AndroidApis/index.php/Login_master/customerRegistration", Parameter: parameters) { result, success, message in
            if success {
              
                if result ["success"] as! Int == 1 {
                    print("Success")
                   
                    
                               // create the alert
                    let alert = UIAlertController(title: "Success", message: result["message"] as! String, preferredStyle: UIAlertController.Style.alert)
                    
                               // add an action (button)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.performSegue(withIdentifier: "segueRegToLogin", sender: nil)}))
                    
                               // show the alert
                               self.present(alert, animated: true, completion: nil)
                    
                    
                } else if result ["success"] as! Int == 0 {
                    let alert = UIAlertController(title: "Failure", message: result["message"] as! String, preferredStyle: UIAlertController.Style.alert)
                    
                               // add an action (button)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                               // show the alert
                               self.present(alert, animated: true, completion: nil)
                } else {
                    print("Result message")
                }
            } else {
                print("Network Error")
            }
            
        }
    }
}

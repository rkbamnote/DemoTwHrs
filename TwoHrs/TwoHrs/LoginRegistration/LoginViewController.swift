//
//  LoginViewController.swift
//  TwoHrs
//
//  Created by Apple on 24/06/22.
//

import UIKit

class LoginViewController: BaseViewController {
    var otp = 0

    @IBOutlet weak var txtMobileNoLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegistrationLogin(_ sender: Any) {
        performSegue(withIdentifier: "segueToRegPage", sender: nil)
    }
    @IBAction func loginBtnAction(_ sender: Any) {
        let mobile = txtMobileNoLogin.text
        
        if ((mobile!).trimmingCharacters(in: .whitespaces).isEmpty){
            print("Please enter mobile number")
            
        } else if (!self.validaPhoneNumber(phoneNumber: mobile!)){
            print("please enter Valid mobile number")
       
        } else {
            self.doLogin()
            
        }
    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "otpscreen" {
            let nextVC = segue.destination as! OTPViewController
            nextVC.mobileNo = txtMobileNoLogin.text as! String
            nextVC.otp = self.otp
        }
    }
}


extension LoginViewController{
    func doLogin(){
        let parameters: [String: Any] = [
//                "mobile" : "7588742940"
            "mobile" : txtMobileNoLogin.text as Any
                
            ]
        
        print(parameters)
        fetchOrSendWithHeaderData(url: Urls.requestOTP, Parameter: parameters) { result, success, message in
            if success {
                if result["success"] as! Int == 1 {
                    print("Success message")
                    
                    let data = result["data"] as! AnyObject
                    self.otp = data["otp"] as! Int
//                    let idUser = data["id"] as! String
//                    let emailU = data["email"] as! String
//                    let mobileU = data["mobile"] as! String
//                    let nameU = data["name"] as! String
//                    let passwordU = data["password"] as! String
//
//                    var mess = "id "+(idUser)+" \nName "+nameU
                    self.performSegue(withIdentifier: "otpscreen", sender: nil)
                           
                } else if(result["success"] as! Int == 0) {
                    print("Your mobile number is not registered, Please Register")
                            			
                } else {
                    print("Result message")
                }
            } else {
                print("Network errors")
            }
        }
    }
}

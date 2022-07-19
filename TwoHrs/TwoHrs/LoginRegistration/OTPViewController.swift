//
//  OTPViewController.swift
//  TwoHrs
//
//  Created by Apple on 24/06/22.
//

import UIKit


class OTPViewController: BaseViewController {
    var mobileNo = ""
    var otp = 0
    
    
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var imgBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgBack.isUserInteractionEnabled = true
        imgBack.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        self.dismiss(animated: true, completion: nil)

       
    }
    
    @IBAction func btnVerifyOTP(_ sender: UIButton) {
        doVerifyOTP()
       
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
extension OTPViewController {
    func doVerifyOTP() {
        let parameters: [String: Any] = ["mobile": self.mobileNo as Any, "otp": self.otp as Any
                                       ]
        print(parameters)
        
        fetchOrSendWithHeaderData(url: Urls.checkOtp , Parameter: parameters) { result, success, message in
            if success {
                
                if result ["success"] as! Int == 1 {
                    print("Success message")
                    let data = result ["data"] as! AnyObject
                    
                    let userID = data["id"] as! String
                    let userName = data["name"] as! String
                    let userEmail = data["email"] as! String
                    let userMobile = data["mobile"] as! String
                    let userAdd = data["address"] as! String
                    
                    UserDefaults.standard.set(true, forKey: userData.isLogin)
                    UserDefaults.standard.set(userID, forKey: userData.userID)
                    UserDefaults.standard.set(userEmail, forKey: userData.userEmail)
                    UserDefaults.standard.set(userMobile, forKey: userData.userMobile)
                    UserDefaults.standard.set(userName, forKey: userData.userName)
                    UserDefaults.standard.set(userAdd, forKey: userData.userAdd)
                    self.performSegue(withIdentifier: "segueToDashboard", sender: nil)
                   
                    
                    
                } else if result ["success"] as! Int == 0 {
                    print("Invalid OTP")
                    
                } else {
                    print("Result message")
                }
            } else {print("Network error")}
            
            
        }
        
    }
}

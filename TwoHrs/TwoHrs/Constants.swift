import Foundation
import UIKit


let baseUrl = "https://2hrs.in/AndroidApis/index.php/"
var imageUrl = "https://2hrs.in/admin/uploads/banners/"
var shopImageUrl = "https://2hrs.in/admin/uploads/vendors/"
struct Urls {
    
    static let requestOTP = baseUrl + "Login_master/requestOtp"
    static let checkOtp = baseUrl + "Login_master/checkOtp"
    static let getShopforCate = baseUrl + "Masters/getshopforcategory"
    static let resendOtp = baseUrl + "Login_master/resendOtp"
    static let custRegister = baseUrl + "Login_master/customerRegistration"
    static let getBanner = baseUrl + "Cms/GetBanners"
    static let getCustProfile = baseUrl + "Login_master/getCustomerProfile"
    static let updateCustProfile = baseUrl + "Login_master/updateCustomerProfile"
    static let getCities = baseUrl + "Masters/getCities"
    
}

struct userData {
    static let isLogin = "isLogin"
    static let userID = "userID"
    static let userEmail = "userEmail"
    static let userName = "userName"
    static let userMobile = "userMobile"
    static let userAdd = "userAdd"
    static let cityID = "cityID"
    static let stateID = "stateID"
    static let cityName = "cityName"
    static let userPin = "userPin"
}


// API's
//https://2hrs.in/AndroidApis/index.php/Login_master/requestOtp
//{"mobile":"7588742940"}
//
//https://2hrs.in/AndroidApis/index.php/Login_master/checkOtp
//{"mobile":"7588742940","otp":"1386"}
//
//https://2hrs.in/AndroidApis/index.php/Login_master/resendOtp
//{"mobile":"7588742940"}
//
//Login_master/customerRegistration
//{"name":"","email":"","address":"","mobile":"","refer_by_id":""}
//
//https://2hrs.in/AndroidApis/index.php/Cms/GetBanners
//
//https://2hrs.in/AndroidApis/index.php/Login_master/getCustomerProfile
//{"customer_id":"7"}
//
//https://2hrs.in/AndroidApis/index.php/Login_master/updateCustomerProfile
//{"customer_id":"7","name":"raj","email":"rkbamnote@hmail.com","mobile":"9403056012","address":"hgd hhk"}
//
//https://2hrs.in/AndroidApis/index.php/Masters/getCities
//{"state_id":"22"}
//pass constant state id as 22
//
//https://2hrs.in/AndroidApis/index.php/Masters/getshopforcategory
//{"pincode":"440022"}

//
//  Models.swift
//  TwoHrs
//
//  Created by Apple on 25/06/22.
//

import Foundation

struct DefaultUserData {
    static let userID = "userID"
    static let userOTP = "userOTP"
    static let customerID = "customerID"
    static let stateID = "stateID"
    static let name = "name"
    static let isLoggedIn = "isLoggedIn"
    static let email = "email"
    static let mobile = "mobile"
    static let address = "address"
    static let pincode = "pincode"
    static let referedKey = "referedKey"
    
}

class ShopModel {
    var catid:  String?
    var categoryname : String?
    var shopname : String?
    var shopimage : String?
    var shopadd : String?
  
    init (catid: String, categoryname: String, shopname: String, shopimage: String, shopadd: String){
        self.catid = catid
        self.categoryname = categoryname
        self.shopname = shopname
        self.shopimage = shopimage
        self.shopadd = shopadd
    }
}
class BannerModel {
    var id:  String?
    var title : String?
    var banner : String?
  
    init (id: String, title: String, banner: String){
        self.id = id
        self.title = title
        self.banner = banner
    }
}


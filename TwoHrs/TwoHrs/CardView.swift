//
//  CardView.swift
//  TwoHrs
//
//  Created by Apple on 24/06/22.
//

import UIKit

@IBDesignable class CardView: UIView {
    var cornnerRadius : CGFloat = 2
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 5
    var shadowColour : UIColor = UIColor.brown
//    var shadowColour : UIColor = MyColor.shadow_color
//    var shadowOpacity : CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
//        layer.shadowOpacity = Float(shadowOpacity)
    }
}

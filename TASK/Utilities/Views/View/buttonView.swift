//
//  buttonView.swift
//
//  Created by Muhammed Elsayed on 10/20/20.
//

import UIKit

@IBDesignable
class buttonView: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.layer.bounds.height/2
        }
    }
    
    @IBInspectable var cornerRadiuscostom: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadiuscostom
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear{
        didSet{
            self.layer.shadowColor  = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0{
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset  : CGSize = CGSize.zero{
        didSet{
            self.layer.shadowOffset  = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0{
        didSet{
            self.layer.shadowRadius  = shadowRadius
        }
    }
    
    
    @IBInspectable var imageHeight : Int = 0 {
        didSet{
        }
    }
    
    
    
    @IBInspectable var imageWidth : Int = 0 {
        didSet {
            
        }
    }
    
    @IBInspectable var cornerCostomTopLeftButtomLeft : Bool = false {
        didSet {
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        }
    }
    
    @IBInspectable var cornerCostomTopLeftTopRight : Bool = false {
        didSet {
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
    }
}

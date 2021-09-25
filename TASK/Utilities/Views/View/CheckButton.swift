//
//  CheckButton.swift
//
//  Created by Muhammed Elsayed on 1/29/21.
//

import UIKit
class CheckButton: UIButton {
    
    override var isSelected: Bool{
        didSet{
            let image = isSelected ?  #imageLiteral(resourceName: "selected") : #imageLiteral(resourceName: "unSelected")
            self.setImage(image, for: .normal)
        }
    }
    
}

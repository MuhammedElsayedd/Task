//
//  TabBarVC.swift
//  TASK
//
//  Created by Muhammed Elsayed on 3/31/21.
//

import UIKit

class CustomizedTabBar: UITabBar {
    
    lazy var centerButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setImage(UIImage(named: "bellman_bottom-icon"), for: .normal)
        button.addTarget(self, action: #selector(centerBtnTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Variables
    var centerButtonTapped: (()->())!
    let buttonSize: CGFloat = 90.0

    @objc func centerBtnTapped(){
        centerButtonTapped()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(centerButton)
        clipsToBounds = false
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerButton.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        centerButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        centerButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        centerButton.layer.cornerRadius = buttonSize / 2
    }

    override func draw(_ rect: CGRect) {
        let shapeLayer = CAShapeLayer()                    // Create a CAShapeLayer
        shapeLayer.path = createPath().cgPath
        shapeLayer.strokeColor = UIColor(hex: "cecfcf").cgColor
        shapeLayer.fillColor = UIColor(hex: "dbddda").cgColor
        shapeLayer.lineWidth = 2.0
        self.layer.insertSublayer(shapeLayer, at: 0)                 // add the new layer to our custom view
    }
    
    func createPath() -> UIBezierPath {
        let radius : CGFloat =  40.0;
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: ((self.frame.width/2) - radius), y: 0))
        path.addArc(withCenter: CGPoint(x: (self.frame.width/2), y: 0), radius: radius, startAngle: CGFloat.pi , endAngle: CGFloat(0) , clockwise: false)
        path.addLine(to: CGPoint(x:self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path
    }
    
}

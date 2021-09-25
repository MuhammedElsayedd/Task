//
//  FloatingMenu.swift
//  TASK
//
//  Created by  Muhammed Elsayed on 01/04/2021.
//

import UIKit

class FloatingMenu: UIView {

    // MARK:- Outlets
    @IBOutlet weak var hotspotsView: UIView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var attractionsView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var hotspotsImgBGView: UIView!
    @IBOutlet weak var eventsImgBGView: UIView!
    @IBOutlet weak var attractionsImgBGView: UIView!
    @IBOutlet weak var mapImgBGView: UIView!
    
    override func awakeFromNib() {
        setupViewUI(view: hotspotsImgBGView)
        setupViewUI(view: eventsImgBGView)
        setupViewUI(view: attractionsImgBGView)
        setupViewUI(view: mapImgBGView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.closeMap()
    }
    
    func setupViewUI(view: UIView){
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 20
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale

    }
    
    func openMap(){
        openAnimation(view: hotspotsView, position: CGPoint(x: -90, y: 0))
        openAnimation(view: eventsView, position: CGPoint(x: -50, y: -70))
        openAnimation(view: attractionsView, position: CGPoint(x: 50, y: -70))
        openAnimation(view: mapView, position: CGPoint(x: 90, y: 0))
    }
    
    func closeMap(){
        closeAnimation(view: hotspotsView)
        closeAnimation(view: eventsView)
        closeAnimation(view: attractionsView)
        closeAnimation(view: mapView)
    }

    func openAnimation(view: UIView, position: CGPoint){
        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: [.beginFromCurrentState], animations: {
            view.alpha = 1
            view.transform = CGAffineTransform(translationX: position.x, y: position.y)
        }, completion: nil)
    }
    
    func closeAnimation(view: UIView){
        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: [.beginFromCurrentState], animations: {
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {_ in
            self.removeFromSuperview()
        })
    }
    
    
}


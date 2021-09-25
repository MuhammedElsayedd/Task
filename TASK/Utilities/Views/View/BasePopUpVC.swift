//
//  BasePopUpVC.swift
//
//  Created by Ahmed Hussien on 11/01/2021.
//

import UIKit

class BasePopUpVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var popupViewDismissed: (() -> ())?
    var firstResponderTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupPresentationAnimation()
    }

    private func setupUI() {
        self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0)
        let translatedY = UIScreen.main.bounds.height
        self.containerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: translatedY)
        
        let selector = #selector(self.dismissPopUpView)
        let tap = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = true
        let backgroundView = containerView.superview
        backgroundView?.addGestureRecognizer(tap)
        
        let containerSelector = #selector(self.containerViewTapped)
        let containerTap = UITapGestureRecognizer(target: self, action: containerSelector)
        self.containerView.addGestureRecognizer(containerTap)
    }
    
    private func setupPresentationAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.backgroundColor = self?.view.backgroundColor?.withAlphaComponent(0.5)
            self?.containerView.transform = CGAffineTransform.identity
        } completion: {[weak self] (_) in
            self?.firstResponderTextField?.becomeFirstResponder()
        }

    }
    
    @objc private func containerViewTapped() {
        self.view.endEditing(true)
    }
    
    @objc func dismissPopUpView() {
        let translatedY = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.backgroundColor = self?.view.backgroundColor?.withAlphaComponent(0)
            self?.containerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: translatedY)
        }, completion: { [weak self] (_) in
            self?.popupViewDismissed?()
            self?.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func dismissGestureTapped(_ sender: Any) {
        self.dismissPopUpView()
    }
}

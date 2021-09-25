//
//  showAlert.swift
//  Cairo Cart
//
//  Created by Muhammed Elsayed on 11/20/20.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "Ok", okHandler: ((UIAlertAction)->Void)? = nil) {
        let message = NSLocalizedString(message, comment: "product list lang")
        let titles = NSLocalizedString(title, comment: "product list lang")
        let alert = UIAlertController(title: titles, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

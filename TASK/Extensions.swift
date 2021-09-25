//
//  Extensions.swift
//
//  Created by Muhammed Elsayed on 5/4/20.
//  Copyright © 2020. All rights reserved.
//
import UIKit
import Kingfisher


/**
 Extension on `Dictionary` that adds different helper methods such as JSON `Data` serialization
 */
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    /**
     Heper method that serializes the `Dictionary` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

public extension UserDefaults {
    
    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    func set<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        set(jsonData, forKey: forKey)
    }
    
    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
}

/**
 Extension on `Array` that adds different helper methods such as JSON `Data` serialization
 */
public extension Array where Element: Any {
    /**
     Heper method that serializes the `Array` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

extension UIColor {
    static let appYellowColor = UIColor(red: 251/255, green: 221/255, blue: 26/255, alpha: 1.0)
    static let appIndigoColor = UIColor(red: 151/255, green: 87/255, blue: 166/255, alpha: 1.0)
    static let appLightGrayColor = UIColor(hex: "#DCDCDC").withAlphaComponent(0.5)
}

extension UIFont {
    static let helveticaNeue22Bold = UIFont(name: "HelveticaNeue-Bold", size: 22)
}

extension UITableView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.tableFooterView = UIView()
    }
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}

extension UITableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}

extension UIView {
    
    func makeItDynamicView() {
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -8
        horizontalMotionEffect.maximumRelativeValue = 8
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -8
        verticalMotionEffect.maximumRelativeValue = 8
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        self.addMotionEffect(motionEffectGroup)
    }
    
    func dropShadow(height: CGFloat = -10) {
        //        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func dropShadow(locatedAt pointX: CGFloat, pointY: CGFloat, blur: CGFloat, opacity: Float, color: UIColor = .black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: pointX, height: pointY)
        self.layer.shadowRadius = blur
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func circulateView() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func drawBorder(with color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        //        self.layer.masksToBounds = true
    }
    func dropCardShadow() {
        self.layer.shadowColor = UIColor.appLightGrayColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 1.0
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
    }
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-4, 4, -4, 4, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-4, 4, -4, 4, -3, 3, -2, 2, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (Double.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
}

func openGMaps(with lat: Double, lng: Double) {
    if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
        UIApplication.shared.open(URL(string:
            "comgooglemaps://?saddr=&daddr=\(lat),\(lng)")!)
        //&directionsmode=driving
    } else {
        UIApplication.shared.open(URL(string: "https://www.google.com.eg/maps/place/@\(lat),\(lng)")!, options: [:], completionHandler: nil)
    }
}
func call(tel: String) {
    if let url = URL(string: "tel://"+tel), UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}



// MARK: - Loader
extension UIViewController {
    func setNavBarLogo() {
        let container = UIView(frame: CGRect(x: 0, y: -8, width: 150, height: 50))
        let imageView = UIImageView()
        container.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: -8, width: 150, height: 50)
//        imageView.image = UIImage(named: "BarLogo-\(Localize.currentLanguage())")
        imageView.image = UIImage(named: "logoBar")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = container
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    func setUpNavColore(_ isTranslucent: Bool, _ title:String = ""){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.0862745098, green: 0.6588235294, blue: 0.7019607843, alpha: 1)
//        let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        nvImageTitle.contentMode = .scaleAspectFit
//        let imageName = UIImage(named: "Mask Group 3")
//        nvImageTitle.image = imageName
//        navigationItem.titleView = nvImageTitle
        navigationController?.navigationBar.topItem?.title = "\(title)"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 18)!] as [NSAttributedString.Key : Any]
//
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }

    var loaderView: LoaderView {
        
        let window = UIApplication.shared.windows.first!
        for view in window.subviews where view is LoaderView {
            return view as! LoaderView
        }
        for view in self.view.subviews where view is LoaderView {
            return view as! LoaderView
        }
        return LoaderView.instanceFromNib()
    }
    
    func animateLoaderView(overContext: Bool = false) {
        let handyLoader = self.loaderView
        if overContext == true {
            let window = UIApplication.shared.windows.filter({return $0.isKeyWindow}).first!
            for view in window.subviews where view is LoaderView {
                return
            }
            handyLoader.frame = window.frame
            window.addSubview(handyLoader)
        } else {
            for view in self.view.subviews where view is LoaderView {
                return
            }
            handyLoader.frame = self.view.bounds
            self.view.addSubview(handyLoader)
        }
    }
    
    func stopLoaderView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loaderView.alpha = 0
        }, completion: { _ in
            self.loaderView.removeFromSuperview()
        })
    }
    
    // Alert with one dismiss action
    func presentAlert(title: String?,
                      message: String,
                      actionTitle: String = "Ok") {
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: actionTitle,
                                     style: .default,
                                     handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Alert with one custom actions handler
    func presentAlert(message: String, title: String = "",
                      actionTitle: String = "Ok",
                      handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: actionTitle,
                                     style: .default,
                                     handler: handler)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Alert with two custom actions handler
    func presentAlert(title: String = "",
                      message: String,
                      actionTitle: String = "Ok",
                      cancelTitle: String = "Cancel",
                      actionHandler: ((UIAlertAction) -> Void)? = nil,
                      cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: actionTitle,
                                     style: .default,
                                     handler: actionHandler)
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .default,
                                         handler: cancelHandler)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backTapped() {
        if let navVC = self.navigationController {
            navVC.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func notifyUserAboutNotificationPermession() {
        let alertController = UIAlertController(title: "Push Notifications Permession Required", message: "Please enable push notifications permissions in settings.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: { _ in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func notifyUserAboutLocationPermession() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: { _ in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

//    func gotoLoginRoot() {
//        let window = UIApplication.shared.windows.filter({return $0.isKeyWindow}).first!
//        let loginVC = LoginVC()
//        window.rootViewController = loginVC
//        if let snapshot = window.snapshotView(afterScreenUpdates: true) {
//            loginVC.view.addSubview(snapshot)
//            window.rootViewController = loginVC
//            window.makeKeyAndVisible()
//            
//            UIView.animate(withDuration: 0.4, animations: {
//                snapshot.layer.opacity = 0
//            }, completion: { _ in
//                snapshot.removeFromSuperview()
//            })
//        }
//    }
    
    // MARK: No Results View
    var noResultsView: NoResultsView {
        
        let window = UIApplication.shared.windows.first!
        for view in window.subviews where view is NoResultsView {
            return view as! NoResultsView
        }
        for view in self.view.subviews where view is NoResultsView {
            return view as! NoResultsView
        }
        return NoResultsView()
    }
    
    func animateNoResultsView(overContext: Bool = false) {
        let noResultsLoader = self.noResultsView
        if overContext == true {
            let window = UIApplication.shared.windows.filter({return $0.isKeyWindow}).first!
            for view in window.subviews where view is NoResultsView {
                return
            }
            noResultsLoader.frame = window.frame
            window.addSubview(noResultsLoader)
        } else {
            for view in self.view.subviews where view is NoResultsView {
                return
            }
            noResultsLoader.frame = self.view.bounds
            self.view.addSubview(noResultsLoader)
        }
    }
    
    func stopNoResultsView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.noResultsView.alpha = 0
        }, completion: { _ in
            self.noResultsView.removeFromSuperview()
        })
    }

}

enum PaymentMethod: String {
    case cash
    case on_delivered
    case bank
    case online
}

extension String {
    
    //    var localized:String{
    //        return NSLocalizedString(self, comment: "")
    //    }
    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = self.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespaces )
    }
    
}

// MARK: - Keyboard
extension UIViewController {
    
    func hideKeyboardWhenTappedAround(WithCancelsTouchesInView flag: Bool = false) {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = flag
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

public enum SocialType: String {
    case facebookType = "facebook"
    case twitterType = "twitter"
    case linkedinType = "linkedin"
    case instagramType = "instagram"
    case pinterestType = "pinterest"
    case whatsapp = "whatsapp"
}

var language: AppLanguage?

public enum AppLanguage: String {
    case arabic = "ar"
    case english = "en"
}

class Defaults {
    struct NotificationKeys {
        static let cartChanged = "cartChanged"
    }
}

extension Defaults {
    struct Keys {
        static let token = "userToken"
    }
}

extension UIColor {
    @nonobjc static var pending = UIColor(red: 247/255, green: 170/255, blue: 23/255, alpha: 1)
    @nonobjc static var processing = UIColor(red: 67/255, green: 152/255, blue: 130/255, alpha: 1)
    @nonobjc static var canceled = UIColor(red: 233/255, green: 28/255, blue: 36/255, alpha: 1)
    @nonobjc static var completed = UIColor(red: 77/255, green: 121/255, blue: 255/255, alpha: 1)
}

enum Status: String, Decodable {
    case pendingState = "pending"
    case processingState = "processing"
    case cancelledState = "canceled"
    case completedState = "completed"
    case other
}

enum PromocodeType: String, Decodable {
    case percentageType = "Percentage"
    case discountType = "Discount"
}


let CARTNOTIFICATION = Notification(name: Notification.Name(Defaults.NotificationKeys.cartChanged), object: nil, userInfo: nil)


extension String {
    var englishNumber: Double {
        let numberStr: String = self
        
        let newString = numberStr.replacingOccurrences(of: "٫", with: ".", options: .literal, range: nil)
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        guard let final = formatter.number(from: newString) else {
            return 0
        }
        return Double(truncating: final)
    }
    var englishNumberInt: Int {
        let numberStr: String = self
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        guard let final = formatter.number(from: numberStr) else {
            return 0
        }
        return Int(truncating: final)
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
   
}

public extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first(where: {return $0.isKeyWindow})!.rootViewController
) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}




extension UIImageView{
 
    func getImage(url: String){
        kf.indicatorType = .activity
        let url = URL(string: url)
        kf.setImage(with: url, placeholder: nil, options: nil) { (result) in
            
            switch result{
            case .success(let value):
                self.image = value.image
            
            case .failure:
                self.image = UIImage(named: "coming_soon")
            }
            
            
        }
        kf.setImage(with: url)
    }
}


extension UIView{

    func setBackgroundBlurry(style: UIBlurEffect.Style) {
        var blurryView: UIView
        if UIAccessibility.isReduceTransparencyEnabled == false {
            backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurryView = blurEffectView
        } else {
            blurryView = UIView()
            blurryView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        addSubviewAndFill(blurryView, position: 0)
    }

    func addSubviewAndFill(_ subView: UIView, position: Int? = nil) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        if let position = position {
            insertSubview(subView, at: position)
        } else {
            addSubview(subView)
        }
        let leading = subView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = subView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let top = subView.topAnchor.constraint(equalTo: topAnchor)
        let bottom = subView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        layoutIfNeeded()
    }

}

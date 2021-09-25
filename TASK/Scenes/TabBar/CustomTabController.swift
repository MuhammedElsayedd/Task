//
//  CustomTabController.swift
//  TASK
//
//  Created by Muhammed Elsayed on 3/31/21.
//

import UIKit


class CustomTabController: UITabBarController {

    let menuView = Bundle.main.loadNibNamed("FloatingMenu", owner: self, options: nil)?.first as! FloatingMenu

    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        
        let customTabbar = tabBar as? CustomizedTabBar
        if let customTabbar = customTabbar{
            customTabbar.centerButtonTapped = {
                self.showMenu()
            }
        }
        
    }
    

    private func showMenu(){
        self.view.addSubview(self.menuView)
        menuView.frame.size = self.view.frame.size
        self.menuView.center = self.view.center
        self.menuView.openMap()
    }

}

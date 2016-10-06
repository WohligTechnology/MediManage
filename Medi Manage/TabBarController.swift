//
//  TabBarController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 11/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var insuredMemberController:UIViewController!

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.moreNavigationController.navigationBar.hidden = true
        let navigationLogo = UIImage(named: "logo_small")
        let navigationImageView = UIImageView(image: navigationLogo)

        self.moreNavigationController.navigationItem.titleView = navigationImageView
        self.moreNavigationController.navigationBar.topItem?.rightBarButtonItem = nil

        self.moreNavigationController.navigationBar.topItem?.leftBarButtonItem = nil
        self.moreNavigationController.navigationBar.barTintColor = UIColor.blackColor()
        self.moreNavigationController.navigationBar.tintColor = UIColor.whiteColor()
        
//        self.tabBarController?.viewControllers![0] = HospitalSearchController
        self.tabBarController?.selectedIndex = tabSelected
//        var tabbar:UITabBar?
        self.selectedIndex = tabSelected
        if let items = self.tabBar.items{
            //self.tabBar.setItems([items[5]], animated: true)
        }
        print("my selected item: \(tabSelected)")
        print("\(self.selectedIndex)")
        print("in tab")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

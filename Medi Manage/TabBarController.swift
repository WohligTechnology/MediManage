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
        
        self.tabBarController?.viewControllers![0] = insuredMemberController
        print("\(self.tabBarController?.viewControllers?.count)")
//        tabBarController.setselec
        print("in tab")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

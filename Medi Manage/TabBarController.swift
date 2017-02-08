//
//  TabBarController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 11/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        
//        rest.isEnrolled({(json:JSON) ->() in
//            var data = json
//            data = false
//            if data == 401 {
//                gEnrollmentMembersController.redirectToHome()
//            }else{
//                print(data)
//                if !data {
//                    print("in if")
//                    tabSelected = 1
//                    self.selectedViewController = self.viewControllers![tabSelected];
//                }else{
//                    print("in else")
                    if isAddMember {
                        tabSelected = 1;
                    }
                    self.selectedViewController = self.viewControllers![tabSelected];
//                }
//            }
//        })
        
//        if let arrayOfTabBarItems = self.tabBar.items as! AnyObject as? NSArray, tabBarItem = arrayOfTabBarItems[2] as? UITabBarItem {
//            tabBarItem.enabled = false
//            print("\(#line) | \(arrayOfTabBarItems)")
//        }
        
//        if let tabBarController = self.tabBarController {
//            let indexToRemove = 3
//            if indexToRemove < tabBarController.viewControllers?.count {
//                var viewControllers = tabBarController.viewControllers
//                viewControllers?.removeAtIndex(indexToRemove)
//                tabBarController.viewControllers = viewControllers
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

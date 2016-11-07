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
        self.moreNavigationController.navigationBar.barTintColor = UIColor.black
        self.moreNavigationController.navigationBar.tintColor = UIColor.white
        
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

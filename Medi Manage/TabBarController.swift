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
        
//        insuredMemberController = storyboard?.instantiateViewControllerWithIdentifier("insuredMemberIdentifier") as! InsuredMembersController
//        navigationController?.pushViewController(insuredMemberController, animated: true)
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

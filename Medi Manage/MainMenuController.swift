//
//  MainMenuController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 24/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gMainMenuController: UIViewController!
var storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)

class MainMenuController: UIViewController, UIGestureRecognizerDelegate {
    
    var insuredMembersController: UIViewController!
    var mainClaimsController: UIViewController!
    var benefitSummaryController: UIViewController!
    var helpDeskController: UIViewController!
    var hospitalSearchController: UIViewController!
    var connectController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navshow()
        gMainMenuController = self
//        self.tabBarController?.tabBar.hidden = false
        rest.isEnrolled({(json:JSON) ->() in
            let data = json
            if !data {
                print("in if")
                gMainMenuController.topendding()
            }
            
        })
        
        self.view.bounds.origin.y = -45
        self.view.frame.size.height = self.view.frame.size.height - 45
        
        // 1
        let insuredMembers = homeMenus(frame: CGRectMake(0, 20, width / 2, self.view.frame.size.height / 3))
        insuredMembers.homeMenuMainView.backgroundColor = UIColor.whiteColor()
        insuredMembers.menuImage.image = UIImage(named: "menu_one")
        insuredMembers.menuTitle.text = "Insured Members"
        self.view.addSubview(insuredMembers)
        let insuredMembersTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.insuredMembersTap(_:)))
        insuredMembersTap.delegate = self
        insuredMembers.addGestureRecognizer(insuredMembersTap)
        
        // 2
        let claims = homeMenus(frame: CGRectMake(width / 2, 20, width / 2, self.view.frame.size.height / 3))
        claims.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        claims.menuImage.image = UIImage(named: "menu_two")
        claims.menuTitle.text = "Claims"
        self.view.addSubview(claims)
        let claimsTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.claimsTap(_:)))
        claimsTap.delegate = self
        claims.addGestureRecognizer(claimsTap)
        
        // 3
        let benefitSummary = homeMenus(frame: CGRectMake(0, self.view.frame.size.height / 3, width / 2, self.view.frame.size.height / 3))
        benefitSummary.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        benefitSummary.menuImage.image = UIImage(named: "menu_three")
        benefitSummary.menuTitle.text = "Benefit Summary"
        self.view.addSubview(benefitSummary)
        let benefitSummaryTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.benefitSummaryTap(_:)))
        benefitSummaryTap.delegate = self
        benefitSummary.addGestureRecognizer(benefitSummaryTap)
        
        // 4
        let helpdesk = homeMenus(frame: CGRectMake(width / 2, self.view.frame.size.height / 3, width / 2, self.view.frame.size.height / 3))
        helpdesk.homeMenuMainView.backgroundColor = UIColor.whiteColor()
        helpdesk.menuImage.image = UIImage(named: "menu_four")
        helpdesk.menuTitle.text = "Helpdesk"
        self.view.addSubview(helpdesk)
        let helpdeskTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.helpdeskTap(_:)))
        helpdeskTap.delegate = self
        helpdesk.addGestureRecognizer(helpdeskTap)
        
        // 5
        let hospitalSearch = homeMenus(frame: CGRectMake(0, self.view.frame.size.height / 1.5, width / 2, self.view.frame.size.height / 3))
        hospitalSearch.homeMenuMainView.backgroundColor = UIColor.whiteColor()
        hospitalSearch.menuImage.image = UIImage(named: "menu_five")
        hospitalSearch.menuTitle.text = "Hospital Search"
        self.view.addSubview(hospitalSearch)
        let hospitalSearchTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.hospitalSearchTap(_:)))
        hospitalSearchTap.delegate = self
        hospitalSearch.addGestureRecognizer(hospitalSearchTap)
        
        // 6
        let connect = homeMenus(frame: CGRectMake(width / 2, self.view.frame.size.height / 1.5, width / 2, self.view.frame.size.height / 3))
        connect.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        connect.menuImage.image = UIImage(named: "menu_six")
        connect.menuTitle.text = "Connect"
        self.view.addSubview(connect)
        let connectTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.connectTap(_:)))
        connectTap.delegate = self
        connect.addGestureRecognizer(connectTap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insuredMembersTap(sender: UITapGestureRecognizer) {
        tabSelected = 1
        let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        self.presentViewController(passcodemodal, animated: true, completion: nil)
    }
    
    func claimsTap(sender: UITapGestureRecognizer) {
        tabSelected = 2
        let im: TabBarController = storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        self.presentViewController(im, animated: true, completion: nil)
    }
    
    func benefitSummaryTap(sender: UITapGestureRecognizer) {
        tabSelected = 3
        let im: TabBarController = storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        self.presentViewController(im, animated: true, completion: nil)
    }
    
    func helpdeskTap(sender: UITapGestureRecognizer) {
        tabSelected = 4
        let im: TabBarController = storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        self.presentViewController(im, animated: true, completion: nil)

    }
    
    func hospitalSearchTap(sender: UITapGestureRecognizer) {
        tabSelected = 5
        let im: TabBarController = storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        self.presentViewController(im, animated: true, completion: nil)

    }
    
    func connectTap(sender: UITapGestureRecognizer) {
        tabSelected = 6
        let im: TabBarController = storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        self.presentViewController(im, animated: true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

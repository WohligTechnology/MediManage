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
    
    var enrollmentJSON: JSON!
    var clientId: String!
    var hasWellness: String!
    
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
        
        rest.EnrolledName({(request) in
            dispatch_async(dispatch_get_main_queue(), {
                
                if request != 1 {
                    
                    self.view.bounds.origin.y = -45
                    self.view.frame.size.height = self.view.frame.size.height - 45
                
                    self.enrollmentJSON = request
                    self.clientId = request["result"][6].stringValue
                    self.hasWellness = request["result"][4].stringValue
                    
                    print("\(#line) | \(request)")
                    
                    if (self.clientId != nil) {
                        defaultToken.setObject(self.clientId, forKey: "clientId")
                    }
                    
                    if (self.hasWellness != nil) {
                        defaultToken.setObject(self.hasWellness, forKey: "hasWellness")
                    }
                    
                    let hasWellness = defaultToken.objectForKey("hasWellness")!
                    
                    if hasWellness as! String == "True" {
                        dashboardItemH = 4
                        dashboardItemY = 2
                        
                        // 7
                        let wellness = homeMenus(frame: CGRectMake(0, self.view.frame.size.height - self.view.frame.size.height / dashboardItemH, width, self.view.frame.size.height / dashboardItemH))
                        wellness.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
                        wellness.menuImage.image = UIImage(named: "menu_seven")
                        wellness.menuTitle.text = "Wellness"
                        self.view.addSubview(wellness)
                        let wellnessTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.wellnessTap(_:)))
                        wellnessTap.delegate = self
                        wellness.addGestureRecognizer(wellnessTap)
                    } else {
                        dashboardItemH = 3
                        dashboardItemY = 1.5
                    }
                    
                    // 1
                    let insuredMembers = homeMenus(frame: CGRectMake(0, 20, width / 2, self.view.frame.size.height / dashboardItemH))
                    insuredMembers.homeMenuMainView.backgroundColor = UIColor.whiteColor()
                    insuredMembers.menuImage.image = UIImage(named: "menu_one")
                    insuredMembers.menuTitle.text = "Insured Members"
                    self.view.addSubview(insuredMembers)
                    let insuredMembersTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.insuredMembersTap(_:)))
                    insuredMembersTap.delegate = self
                    insuredMembers.addGestureRecognizer(insuredMembersTap)
                    
                    // 2
                    let claims = homeMenus(frame: CGRectMake(width / 2, 20, width / 2, self.view.frame.size.height / dashboardItemH))
                    claims.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
                    claims.menuImage.image = UIImage(named: "menu_two")
                    claims.menuTitle.text = "Claims"
                    self.view.addSubview(claims)
                    let claimsTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.claimsTap(_:)))
                    claimsTap.delegate = self
                    claims.addGestureRecognizer(claimsTap)
                    
                    // 3
                    let benefitSummary = homeMenus(frame: CGRectMake(0, self.view.frame.size.height / dashboardItemH, width / 2, self.view.frame.size.height / dashboardItemH))
                    benefitSummary.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
                    benefitSummary.menuImage.image = UIImage(named: "menu_three")
                    benefitSummary.menuTitle.text = "Benefit Summary"
                    self.view.addSubview(benefitSummary)
                    let benefitSummaryTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.benefitSummaryTap(_:)))
                    benefitSummaryTap.delegate = self
                    benefitSummary.addGestureRecognizer(benefitSummaryTap)
                    
                    // 4
                    let helpdesk = homeMenus(frame: CGRectMake(width / 2, self.view.frame.size.height / dashboardItemH, width / 2, self.view.frame.size.height / dashboardItemH))
                    helpdesk.homeMenuMainView.backgroundColor = UIColor.whiteColor()
                    helpdesk.menuImage.image = UIImage(named: "menu_four")
                    helpdesk.menuTitle.text = "Help Desk"
                    self.view.addSubview(helpdesk)
                    let helpdeskTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.helpdeskTap(_:)))
                    helpdeskTap.delegate = self
                    helpdesk.addGestureRecognizer(helpdeskTap)
                    
                    // 5
                    let hospitalSearch = homeMenus(frame: CGRectMake(0, self.view.frame.size.height / dashboardItemY, width / 2, self.view.frame.size.height / dashboardItemH))
                    hospitalSearch.homeMenuMainView.backgroundColor = UIColor.whiteColor()
                    hospitalSearch.menuImage.image = UIImage(named: "menu_five")
                    hospitalSearch.menuTitle.text = "Hospital Search"
                    self.view.addSubview(hospitalSearch)
                    let hospitalSearchTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.hospitalSearchTap(_:)))
                    hospitalSearchTap.delegate = self
                    hospitalSearch.addGestureRecognizer(hospitalSearchTap)
                    
                    // 6
                    let connect = homeMenus(frame: CGRectMake(width / 2, self.view.frame.size.height / dashboardItemY, width / 2, self.view.frame.size.height / dashboardItemH))
                    connect.homeMenuMainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
                    connect.menuImage.image = UIImage(named: "menu_six")
                    connect.menuTitle.text = "Connect"
                    self.view.addSubview(connect)
                    let connectTap = UITapGestureRecognizer(target: self, action: #selector(MainMenuController.connectTap(_:)))
                    connectTap.delegate = self
                    connect.addGestureRecognizer(connectTap)
                    
                    if let tabBarController = self.tabBarController {
                        let indexToRemove = 3
                        if indexToRemove < tabBarController.viewControllers?.count {
                            print(tabBarController.viewControllers?.count)
                            var viewControllers = tabBarController.viewControllers
                            viewControllers?.removeAtIndex(indexToRemove)
                            tabBarController.viewControllers = viewControllers
                            print(tabBarController.viewControllers?.count)
                            print("\(#line) | \(viewControllers)")
                            self.tabBarController?.viewControllers = viewControllers
                            self.tabBarController?.reloadInputViews()
                            self.tabBarController?.viewWillLayoutSubviews()
                            print("\(#line) | \(self.tabBarController?.viewControllers?.count)")
                            print("\(#line) | \(self.tabBarController?.tabBar.items!.count)")
                        }
                    }
                    
                } else {
                    
                    let alertController = UIAlertController(title: "No Connection", message:
                        "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
            })
        })

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let tabBarController = self.tabBarController {
            let indexToRemove = 3
            
            let tabBarControllerItems = self.tabBarController?.tabBar.items
            
            if let tabArray = tabBarControllerItems {
                let tabBarItem1 = tabArray[0]
                tabBarItem1.enabled = false
            }
        }
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
    
    func wellnessTap(sender: UITapGestureRecognizer) {
        tabSelected = 7
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

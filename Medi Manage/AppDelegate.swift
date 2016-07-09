//
//  AppDelegate.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 28/04/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var Employee_API_KEY : String = ""
var EmployeeFullName  : String = ""
var EmployeeBirthDate : String = ""
var EmployeeNo : String = ""

let bounds = UIScreen.mainScreen().bounds
let width = bounds.size.width
let height = bounds.size.height
let mainBlueColor = UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255) // #15b1e6
let rest = RestApi()
var categoryId : String = ""
struct defaultsKeys {
    static let token = ""
    static let keyTwo = "secondStringKey"
    static let categoryId = 0
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    
    internal func createMenuView() {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var nvc: UINavigationController!
//        
//        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("mainMenuIdentifier") as! MainMenuController
//        
//        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("insuredMemberIdentifier") as! InsuredMembersController
//        
//        nvc = UINavigationController(rootViewController: mainViewController)
//        
//        leftViewController.insuredMembersController = nvc
//        
//        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
//        
//        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//        self.window?.rootViewController = slideMenuController
//        self.window?.makeKeyAndVisible()
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        createMenuView()
        
//        let pageController = UIPageControl.appearance()
//        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
//        pageController.currentPageIndicatorTintColor = UIColor.whiteColor()
//        pageController.backgroundColor = UIColor.clearColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


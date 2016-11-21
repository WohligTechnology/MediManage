//
//  AppDelegate.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 28/04/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var Employee_API_KEY : String = ""
var EmployeeFullName  : String = ""
var EmployeeBirthDate : String = ""
var EmployeeNo : String = ""

var widthGlo = bounds.size.width
var heightGlo = bounds.size.height


let bounds = UIScreen.mainScreen().bounds
let width = bounds.size.width
let height = bounds.size.height
let mainBlueColor = UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255) // #15b1e6
let rest = RestApi()
var categoryId : String = ""
var pdfname : String = ""
var isVarifiedToEdit : BooleanType = false
var forgotMobileNumber : String! = ""
var forgotCountryCode : String! = ""
var profilePassword : String! = ""
var hospitalSearchText : String! = ""
var profileState : String! = ""
var OTPStatus = 0 // 1 : from profile 2: forgot passwordSendOtp
var selectedIndex = 0
var selectedViewController : Bool = false
var isAddMember : Bool = false
var claim = 0
var myClaim = 0
var activeClaim = 0
var checkPreRe = 0
var preAuthOne = 0
var tabSelected = 0
struct defaultsKeys {
    static let token = ""
    static let keyTwo = "secondStringKey"
    static let categoryId = 0
    
}
var signUpUser : JSON = ""
var countryCodes = [["Afghanistan","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla","Antarctica","Antigua & Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Caribbean Netherlands","Bosnia","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos (Keeling) Islands","Colombia","Comoros","Congo - Brazzaville","Congo - Kinshasa","Cook Islands","Costa Rica","Croatia","Cuba","Curaçao","Cyprus","Czech Republic","Côte d’Ivoire","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Guiana","French Polynesia","French Southern Territories","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haiti","Heard & McDonald Islands","Vatican City","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kiribati","North Korea","South Korea","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Niue","Norfolk Island","Northern Mariana Islands","Norway","Oman","Pakistan","Palau","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn Islands","Poland","Portugal","Puerto Rico","Qatar","Romania","Russia","Rwanda","Reunion","St. Barthelemy","St. Helena","St. Kitts & Nevis","St. Lucia","St. Martin","St. Pierre & Miquelon","St. Vincent & Grenadines","Samoa","San Marino","Sao Tome & Príncipe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Sint Maarten","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia & South Sandwich Islands","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Svalbard & Jan Mayen","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor-Leste","Togo","Tokelau","Tonga","Trinidad & Tobago","Tunisia","Turkey","Turkmenistan","Turks & Caicos Islands","Tuvalu","Uganda","Ukraine","United Arab Emirates","UK","US","Uruguay","Uzbekistan","Vanuatu","Venezuela","Vietnam","British Virgin Islands","U.S. Virgin Islands","Wallis & Futuna","Western Sahara","Yemen","Zambia","Zimbabwe","Aland Islands","Dominican Republic","Dominican Republic"],["93","355","213","1-684","376","244","1-264","672","1-268","54","374","297","61","43","994","1-242","973","880","1-246","375","32","501","229","1-441","975","591","599","387","267","47","55","246","673","359","226","257","855","237","1","238","1-345","236","235","56","86","61","61","57","269","242","243","682","506","385","53","599","357","420","225","45","253","1-767","1-809","593","20","503","240","291","372","251","500","298","679","358","33","594","689","262","241","220","995","49","233","350","30","299","1-473","590","1-671","502","44","224","245","592","509","672","39-06","504","852","36","354","91","62","98","964","353","44","972","39","1-876","81","44","962","7","254","686","850","82","965","996","856","371","961","266","231","218","423","370","352","853","389","261","265","60","960","223","356","692","596","222","230","262","52","691","373","377","976","382","1-664","212","258","95","264","674","977","31","687","64","505","227","234","683","672","1-670","47","968","92","680","970","507","675","595","51","63","870","48","351","1","974","40","7","250","262","590","290 n","1-869","1-758","590","508","1-784","685","378","239","966","221","381 p","248","232","65","1-721","421","386","677","252","27","500","211","34","94","249","597","47","268","46","41","963","886","992","255","66","670","228","690","676","1-868","216","90","993","1-649","688","256","380","971","44","1","598","998","678","58","84","1-284","1-340","681","212","967","260","263","358","1-849","1-829"]]

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
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let token = defaultToken.stringForKey("access_token")
        let splashscrn = defaultToken.stringForKey("onSplashScreen")
        
        if token != nil {
            
            
            
            let exampleViewController: TabBarController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
            self.window?.rootViewController = exampleViewController

            
        }else{
            if splashscrn != nil {
                let exampleViewController: LoginController = mainStoryboard.instantiateViewControllerWithIdentifier("loginc") as! LoginController
                self.window?.rootViewController = exampleViewController
            }else{
                let exampleViewController: PageViewerController = mainStoryboard.instantiateViewControllerWithIdentifier("pageViewCtlr") as! PageViewerController
                self.window?.rootViewController = exampleViewController
            }
        }
        
        
        
        self.window?.makeKeyAndVisible()
        
        
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
//
extension UIViewController {
    
    func navshow() {
        let navigationLogo = UIImage(named: "logo_small")
        let navigationImageView = UIImageView(image: navigationLogo)
        self.navigationItem.titleView = navigationImageView
        let infoImage = UIImage(named: "settings")
        let imgWidth = 25
        let imgHeight = 25
        let button:UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: imgWidth, height: imgHeight))
        button.setBackgroundImage(infoImage, forState: .Normal)
        button.addTarget(self, action: #selector(UIViewController.rightNavItemEditClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func checkSession() {
        rest.Hospital("mumbai%20fortis", completion: {(json:JSON) ->() in
            if json == 1{
                let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
                
                self.presentViewController(passcodemodal, animated: true, completion: nil)
            }
        })
    }
    
    func redirectToHome() {
        let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
        
        self.presentViewController(passcodemodal, animated: true, completion: nil)
    }
    func redirectToAddMember() {
        isAddMember = true
        let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        
        self.presentViewController(passcodemodal, animated: true, completion: nil)
    }
    func topendding() {
        tabSelected = 1
        let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
        
        self.presentViewController(passcodemodal, animated: true, completion: nil)
    }
    
    func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    func rightNavItemEditClick(sender:UIButton!) {
        
        print(selectedViewController)
       
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // CANCEL BUTTON
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in}
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        // CHANGEPASSWORD BUTTON
        let changePasswordActionButton: UIAlertAction = UIAlertAction(title: "Change Password", style: .Default){ action -> Void in
            let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("changePass") as! ChangePassword
            
            self.presentViewController(passcodemodal, animated: true, completion: nil)

        }
        actionSheetControllerIOS8.addAction(changePasswordActionButton)
        
        // EDIT PROFILE BUTTON
        let editProfileActionButton: UIAlertAction = UIAlertAction(title: "Edit Profile", style: .Default){ action -> Void in
            profileState = "Edit"
            let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("completeProfile") as! CompleteProfileController
            
            self.presentViewController(passcodemodal, animated: true, completion: nil)
            
        }
        actionSheetControllerIOS8.addAction(editProfileActionButton)
        
        if selectedViewController {
            let editProfileActionButton: UIAlertAction = UIAlertAction(title: "Add Members", style: .Default){ action -> Void in
                isAddMember = true
                let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
                
                self.presentViewController(passcodemodal, animated: true, completion: nil)
                
            }
            actionSheetControllerIOS8.addAction(editProfileActionButton)
        }
        
        // LOGOUT BUTTON
        let logoutActionButton: UIAlertAction = UIAlertAction(title: "Logout", style: .Destructive){ action -> Void in
            defaultToken.removeObjectForKey("access_token")
            let passcodemodal = self.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
            
            self.presentViewController(passcodemodal, animated: true, completion: nil)
            
        }
        actionSheetControllerIOS8.addAction(logoutActionButton)
        
        // PRESENT VIEW SENDER
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }
}

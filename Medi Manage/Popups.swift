//
//  Popups.swift
//  MediManage
//
//  Created by Jagruti Patil on 02/06/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

class Popups: NSObject {
    class var SharedInstance: Popups {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Popups? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Popups()
        }
        return Static.instance!
    }
    
    var alertComletion : ((String) -> Void)!
    var alertButtons : [String]!
    
    func ShowAlert(sender: UIViewController, title: String, message: String, buttons : [String], completion: ((buttonPressed: String) -> Void)?) {
        
        let aboveIOS7 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)
        if(aboveIOS7) {
            
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            for b in buttons {
                
                alertView.addAction(UIAlertAction(title: b, style: UIAlertActionStyle.Default, handler: {
                    (action : UIAlertAction) -> Void in
                    completion!(buttonPressed: action.title!)
                }))
            }
            sender.presentViewController(alertView, animated: true, completion: nil)
            
        } else {
            
            self.alertComletion = completion
            self.alertButtons = buttons
            let alertView  = UIAlertView()
            alertView.delegate = self
            alertView.title = title
            alertView.message = message
            for b in buttons {
                
                alertView.addButtonWithTitle(b)
                
            }
            alertView.show()
        }
        
    }
    
    func ShowPopup(title : String, message : String) {
        let alert: UIAlertView = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    func showalt(sender: UIViewController) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Settings", message: nil, preferredStyle: .ActionSheet)
        
        // CANCEL BUTTON
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in}
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        // CHANGEPASSWORD BUTTON
        let changePasswordActionButton: UIAlertAction = UIAlertAction(title: "Change Password", style: .Default){ action -> Void in}
        actionSheetControllerIOS8.addAction(changePasswordActionButton)
        
        // EDIT PROFILE BUTTON
        let editProfileActionButton: UIAlertAction = UIAlertAction(title: "Edit Profile", style: .Default){ action -> Void in
            
            let passcodemodal = storyboard?.instantiateViewControllerWithIdentifier("completeProfile") as! CompleteProfileController
            
            sender.presentViewController(passcodemodal, animated: true, completion: nil)

        }
        actionSheetControllerIOS8.addAction(editProfileActionButton)
        
        // LOGOUT BUTTON
        let logoutActionButton: UIAlertAction = UIAlertAction(title: "Logout", style: .Destructive){ action -> Void in}
        actionSheetControllerIOS8.addAction(logoutActionButton)
        
        // PRESENT VIEW SENDER
        sender.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }

}

extension Popups: UIAlertViewDelegate {
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(self.alertComletion != nil) {
            self.alertComletion!(self.alertButtons[buttonIndex])
        }
    }
    
}
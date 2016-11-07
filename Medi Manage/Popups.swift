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
    fileprivate static var __once: () = {
            Static.instance = Popups()
        }()
    class var SharedInstance: Popups {
        struct Static {
            static var onceToken: Int = 0
            static var instance: Popups? = nil
        }
        _ = Popups.__once
        return Static.instance!
    }
    
    var alertComletion : ((String) -> Void)!
    var alertButtons : [String]!
    
    func ShowAlert(_ sender: UIViewController, title: String, message: String, buttons : [String], completion: ((_ buttonPressed: String) -> Void)?) {
        
        let aboveIOS7 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)
        if(aboveIOS7) {
            
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for b in buttons {
                
                alertView.addAction(UIAlertAction(title: b, style: UIAlertActionStyle.default, handler: {
                    (action : UIAlertAction) -> Void in
                    completion!(action.title!)
                }))
            }
            sender.present(alertView, animated: true, completion: nil)
            
        } else {
            
            self.alertComletion = completion
            self.alertButtons = buttons
            let alertView  = UIAlertView()
            alertView.delegate = self
            alertView.title = title
            alertView.message = message
            for b in buttons {
                
                alertView.addButton(withTitle: b)
                
            }
            alertView.show()
        }
        
    }
    
    func ShowPopup(_ title : String, message : String) {
        let alert: UIAlertView = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
    func showalt(_ sender: UIViewController) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
        
        // CANCEL BUTTON
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in}
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        // CHANGEPASSWORD BUTTON
        let changePasswordActionButton: UIAlertAction = UIAlertAction(title: "Change Password", style: .default){ action -> Void in}
        actionSheetControllerIOS8.addAction(changePasswordActionButton)
        
        // EDIT PROFILE BUTTON
        let editProfileActionButton: UIAlertAction = UIAlertAction(title: "Edit Profile", style: .default){ action -> Void in
            
            let passcodemodal = storyboard?.instantiateViewController(withIdentifier: "completeProfile") as! CompleteProfileController
            
            sender.present(passcodemodal, animated: true, completion: nil)

        }
        actionSheetControllerIOS8.addAction(editProfileActionButton)
        
        // LOGOUT BUTTON
        let logoutActionButton: UIAlertAction = UIAlertAction(title: "Logout", style: .destructive){ action -> Void in}
        actionSheetControllerIOS8.addAction(logoutActionButton)
        
        // PRESENT VIEW SENDER
        sender.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }

}

extension Popups: UIAlertViewDelegate {
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if(self.alertComletion != nil) {
            self.alertComletion!(self.alertButtons[buttonIndex])
        }
    }
    
}

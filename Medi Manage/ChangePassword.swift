//
//  ChangePassword.swift
//  MediManage
//
//  Created by Jagruti  on 30/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePassword: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        //statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.view.addSubview(statusBar)
        navshow()
        self.currentPassword.delegate = self
        self.newPassword.delegate = self
        self.confPassword.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        currentPassword.resignFirstResponder()
        newPassword.resignFirstResponder()
        confPassword.resignFirstResponder()
        return true
    }
    
    @IBAction func Submit(sender: AnyObject) {
        if currentPassword.text != "" && newPassword.text != "" && confPassword.text != "" {

            rest.changePassword(self.currentPassword.text!, np: self.newPassword.text!, cnp: self.confPassword.text!, completion: {(json:JSON) ->() in
                print(json)
                if json["state"] {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    Popups.SharedInstance.ShowPopup("Change Password", message: json["error_message"].stringValue)
                }
            })
        }else{
            Popups.SharedInstance.ShowPopup("Change Password", message: "Please Enter All Fields.")
        }
    }
}

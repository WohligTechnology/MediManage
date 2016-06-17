//
//  login.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 04/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

@IBDesignable class login: UIView {
    
  
    var TestId = "9920590849"
    var TestPWD = "75476145"
    
    @IBAction func signupCall(sender: AnyObject) {
        gLoginController.performSegueWithIdentifier("signup", sender: nil)
    }
    
    
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        mobile.text = TestId
        password.text = TestPWD
    }
    
    func addPadding(width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRectMake(0, 0, width, myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.Always
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "login", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        addPadding(15, myView: mobile)
        addPadding(15, myView: password)
    }
    @IBAction func onLogin(sender: AnyObject) {
        
        if(mobile.text == "" || password.text == "")
        {
           Popups.SharedInstance.ShowPopup("Login", message: "Both Fields are Required")
        }
        else{
        rest.loginAlaomFire(mobile.text!, password: password.text!, completion: {(json:JSON) -> () in
            dispatch_async(dispatch_get_main_queue(),{
            if(String(json["error"]) != "null")
            {
                let stError :String = String(json ["error"])
                
                let dialog = UIAlertController(title: "Login", message: stError, preferredStyle: UIAlertControllerStyle.Alert)
                
                dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.Destructive, handler:{
                    action in
                 self.mobile.text = ""
                    self.password.text = ""
                    
                }))
                gLoginController.presentViewController(dialog, animated: true, completion: nil)
                }
                else
            {
              //  Popups.SharedInstance.ShowPopup("Welcome", message: "Login Successfull !")
                Employee_API_KEY = String(json["access_token"])
                let dialog = UIAlertController(title: "Welcome", message: "Login Successfull!" ,preferredStyle: UIAlertControllerStyle.Alert)
                
                dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{
                    action in
                    
                    let vc = gLoginController.storyboard?.instantiateViewControllerWithIdentifier("EnrollmentMember") as! EnrollmentMembersController
                  
                  //  vc.RESULT = "Result"
                    gLoginController.presentViewController(vc, animated: true, completion: nil)
                    
                // gLoginController.performSegueWithIdentifier("memberlist", sender: nil)
                    
                }))
                gLoginController.presentViewController(dialog,animated: true, completion: nil)
                
                }
            })
        })
    }
    }


}
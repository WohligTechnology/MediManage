//
//  enterOTP.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 09/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class forgotPasswordOTP: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var enterOTP: UITextField!
    @IBOutlet weak var resetOTP: UIButton!
    @IBOutlet weak var submitOTP: UIButton!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var multiColor: UILabel!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addPadding(width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRectMake(0, 0, width, myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.Always
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "forgotPasswordOTP", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        enterOTP.delegate = self
        newPassword.delegate = self
        confirmPassword.delegate = self
        
        addPadding(15, myView: enterOTP)
        addPadding(15, myView: newPassword)
        addPadding(15, myView: confirmPassword)
        resetOTP.layer.borderWidth = 1
        resetOTP.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).CGColor
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        enterOTP.resignFirstResponder()
        return true
    }
    
    @IBAction func resendOTP(sender: AnyObject) {
        
            rest.SendOtp(forgotMobileNumber, countrycode: forgotCountryCode, completion: {(json:JSON) -> () in
                if json["state"] {
                    Popups.SharedInstance.ShowPopup("", message: "OTP is send to your Mobile Number")
                    
                }
                print("resend otp")
                print(json)
            })
    }
    
    @IBAction func enrollmentmembersCall(sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gForgotPasswordOTPController.view)
        var params = ["Code":"","newPassword":"","confirmPassword":""]
        params["Code"] = enterOTP.text! as String
        params["newPassword"] = newPassword.text! as String
        params["confirmPassword"] = confirmPassword.text! as String
        rest.ResetPassword(JSON(params), completion: {(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue()){
                LoadingOverlay.shared.hideOverlayView()
                print(json)
                if json["state"] {
                    
                        let vc = gForgotPasswordOTPController.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
                        gForgotPasswordOTPController.presentViewController(vc, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func otpBack(sender: AnyObject) {
        
            gForgotPasswordOTPController.performSegueWithIdentifier("otpback", sender: nil)
        let vc = gForgotPasswordOTPController.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
    }
}
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

class enterOTP: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var enterOTP: UITextField!
    @IBOutlet weak var resetOTP: UIButton!
    @IBOutlet weak var submitOTP: UIButton!
    @IBOutlet weak var multiColor: UILabel!
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
        let nib = UINib(nibName: "enterOTP", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        enterOTP.delegate = self
        
        addPadding(15, myView: enterOTP)
        resetOTP.layer.borderWidth = 1
        resetOTP.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).CGColor
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        enterOTP.resignFirstResponder()
        return true
    }
    
    @IBAction func resendOTP(sender: AnyObject) {
        if OTPStatus == 1 {
            rest.ClientSendOTP(forgotMobileNumber, password: profilePassword, completion: {(json:JSON) -> () in
                if json["state"] {
                    Popups.SharedInstance.ShowPopup("", message: "OTP is send to your Mobile Number")

                }
                print(json)
            })
        }else{
            rest.SendOtp(forgotMobileNumber, countrycode: forgotCountryCode, completion: {(json:JSON) -> () in
                if json["state"] {
                    Popups.SharedInstance.ShowPopup("", message: "OTP is send to your Mobile Number")

                }
                print("resend otp")
                print(json)
            })
        }
        
    }
    
    @IBAction func enrollmentmembersCall(sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gEnterOTPController.view)
        rest.ConfirmOtp(String(UTF8String: self.enterOTP.text!)!, completion: {(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue()){
                LoadingOverlay.shared.hideOverlayView()
                if json["state"] {
                    if OTPStatus == 1 {
                        isVarifiedToEdit = true
                        
                        gEnterOTPController.performSegueWithIdentifier("otpdonetoprofile", sender: nil)
                    }else{
                        let vc = gEnterOTPController.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
                        gEnterOTPController.presentViewController(vc, animated: true, completion: nil)
                    }
                }
            }
        })
    }
    
    @IBAction func otpBack(sender: AnyObject) {
        if OTPStatus == 1 {
            
            gEnterOTPController.performSegueWithIdentifier("otpdonetoprofile", sender: nil)
        }else if OTPStatus == 2{
            gEnterOTPController.performSegueWithIdentifier("otpback", sender: nil)
        }
    }
}
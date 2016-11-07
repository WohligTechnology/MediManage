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
    
    func addPadding(_ width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.always
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "forgotPasswordOTP", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview);
        
        enterOTP.delegate = self
        newPassword.delegate = self
        confirmPassword.delegate = self
        
        addPadding(15, myView: enterOTP)
        addPadding(15, myView: newPassword)
        addPadding(15, myView: confirmPassword)
        resetOTP.layer.borderWidth = 1
        resetOTP.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterOTP.resignFirstResponder()
        return true
    }
    
    @IBAction func resendOTP(_ sender: AnyObject) {
        
            rest.SendOtp(forgotMobileNumber, countrycode: forgotCountryCode, completion: {(json:JSON) -> () in
                if json["state"] {
                    Popups.SharedInstance.ShowPopup("", message: "OTP is send to your Mobile Number")
                    
                }
                print("resend otp")
                print(json)
            })
    }
    
    @IBAction func enrollmentmembersCall(_ sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gForgotPasswordOTPController.view)
        rest.ResetPassword(enterOTP.text! as String,password: newPassword.text! as String,confirmPassword: confirmPassword.text! as String,completion: {(json:JSON) -> () in
            dispatch_get_main_queue().sync(DispatchQueue.main){
                LoadingOverlay.shared.hideOverlayView()
                print(json)
                if json["state"] {
                        let vc = gForgotPasswordOTPController.storyboard?.instantiateViewController(withIdentifier: "loginc") as! LoginController
                        gForgotPasswordOTPController.present(vc, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func otpBack(_ sender: AnyObject) {
        
            gForgotPasswordOTPController.performSegue(withIdentifier: "otpback", sender: nil)
        let vc = gForgotPasswordOTPController.storyboard?.instantiateViewController(withIdentifier: "loginc") as! LoginController
    }
}

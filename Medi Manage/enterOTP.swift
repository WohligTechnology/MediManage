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
    
    func addPadding(_ width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.always
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "enterOTP", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview);
        
        enterOTP.delegate = self
        
        addPadding(15, myView: enterOTP)
        resetOTP.layer.borderWidth = 1
        resetOTP.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterOTP.resignFirstResponder()
        return true
    }
    
    @IBAction func resendOTP(_ sender: AnyObject) {
        
        rest.ClientSendOTP(forgotMobileNumber, password: profilePassword, completion: {(json:JSON) -> () in
            dispatch_get_main_queue().sync(DispatchQueue.main){
                if json["state"] {
                    Popups.SharedInstance.ShowPopup("", message: "OTP is send to your Mobile Number")
                    
                }
                print(json)
            }
        })
    }
    
    @IBAction func enrollmentmembersCall(_ sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gEnterOTPController.view)
        rest.ConfirmOtp(String(UTF8String: self.enterOTP.text!)!, completion: {(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue()){
                LoadingOverlay.shared.hideOverlayView()
                if json["state"] {
                        profileState = "Submit"
                        
                    let vc = gEnterOTPController.storyboard?.instantiateViewControllerWithIdentifier("completeProfile") as! CompleteProfileController
                    
                    gEnterOTPController.presentViewController(vc, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func otpBack(_ sender: AnyObject) {
        let vc = gEnterOTPController.storyboard?.instantiateViewController(withIdentifier: "retrieveLogin") as! RetrieveLoginController
        
        gEnterOTPController.present(vc, animated: true, completion: nil)

    }
}

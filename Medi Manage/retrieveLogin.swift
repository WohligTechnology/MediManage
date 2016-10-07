//
//  retrieveLogin.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 09/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class retrieveLogin: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var password: UITextField!
    var countryPickerView = UIPickerView()

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
        let nib = UINib(nibName: "retrieveLogin", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
        
        self.mobileNo.delegate = self
        self.password.delegate = self
        
        addPadding(15, myView: mobileNo)
        addPadding(15, myView: password)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        mobileNo.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    @IBAction func loginCall(sender: AnyObject) {
        profileState = "Edit"
        let vc = gRetrieveLoginController.storyboard?.instantiateViewControllerWithIdentifier("completeProfile") as! CompleteProfileController
        
        gRetrieveLoginController.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func generateotpcall(sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gRetrieveLoginController.view)
        forgotMobileNumber = String(self.mobileNo.text!)
        profilePassword = String(self.password.text!)
        rest.ClientSendOTP(String(self.mobileNo.text!), password: String(self.password.text!), completion: {(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue()){
                print(json)
                LoadingOverlay.shared.hideOverlayView()
                if json["state"] {
                    let vc = gRetrieveLoginController.storyboard?.instantiateViewControllerWithIdentifier("enterOTP") as! EnterOTPController
                    
                    gRetrieveLoginController.presentViewController(vc, animated: true, completion: nil)
                }
            }
        })
    }
}

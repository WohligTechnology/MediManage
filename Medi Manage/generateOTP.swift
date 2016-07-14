//
//  generateOTP.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 09/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class generateOTP: UIView, UITextViewDelegate {
    
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var multiColor: UILabel!
    @IBOutlet weak var countryCode: UITextField!
    
    let allowNumbers = 10
    
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
        let nib = UINib(nibName: "generateOTP", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        addPadding(15, myView: mobileNumber)
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
        
    }
    
    @IBAction func enterotpCall(sender: AnyObject) {
        
        OTPStatus = 2
        forgotMobileNumber? = String(UTF8String: self.mobileNumber.text!)!
        forgotCountryCode? = String(UTF8String: self.countryCode.text!)!

        rest.SendOtp(String(UTF8String: self.mobileNumber.text!)!, countrycode: String(UTF8String: self.countryCode.text!)!, completion: {(json:JSON) -> () in
            dispatch_async(dispatch_get_main_queue()){
                if json["state"]{
                    gGenerateOTPController.performSegueWithIdentifier("toOTPPage", sender: nil)
                }
            }
        })
    }
}
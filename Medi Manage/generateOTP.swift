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

class generateOTP: UIView, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var multiColor: UILabel!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var countryCodeCode: UITextField!
    
    let allowNumbers = 10
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
        let nib = UINib(nibName: "generateOTP", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        let imageView = UIImageView()
        let image = UIImage(named: "triangle_orange")
        imageView.image = image
        
        imageView.frame = CGRect(x: countryCode.frame.size.width + 30, y: 20, width: 10, height: 10)
        countryCode.addSubview(imageView)
        
        addPadding(15, myView: mobileNumber)
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
        mobileNumber.delegate = self
        
        // dropdown list
        
        countryPickerView.delegate = self
        countryCode.inputView = countryPickerView
        countryCode.delegate = self
        countryCode.text = "India"
        countryCodeCode.text = "91"
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(completeProfile.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        countryCode.inputAccessoryView = toolBar
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        mobileNumber.resignFirstResponder()
        return true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCodes[0].count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryCodes[0][row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        countryCodeCode.text = countryCodes[1][row]
        countryCode.text = countryCodes[0][row]
    }
    func donePicker(){
        countryCode.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        let passcodemodal = gGenerateOTPController.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
        
        gGenerateOTPController.presentViewController(passcodemodal, animated: true, completion: nil)

    }
    @IBAction func enterotpCall(sender: AnyObject) {
        if self.mobileNumber.text == "" || self.countryCodeCode.text == "" {
            Popups.SharedInstance.ShowPopup("", message: "Both Fields are Required")

        }else{
        LoadingOverlay.shared.showOverlay(gGenerateOTPController.view)
        OTPStatus = 2
        forgotMobileNumber? = String(UTF8String: self.mobileNumber.text!)!
        forgotCountryCode? = String(UTF8String: self.countryCode.text!)!

        rest.SendOtp(String(UTF8String: self.mobileNumber.text!)!, countrycode: String(UTF8String: self.countryCode.text!)!, completion: {(json:JSON) -> () in
            dispatch_async(dispatch_get_main_queue()){
                print(json)
                LoadingOverlay.shared.hideOverlayView()
                if json["state"]{
                    let passcodemodal = gGenerateOTPController.storyboard?.instantiateViewControllerWithIdentifier("forgotOTP") as! ForgotPasswordOTPController
                    
                    gGenerateOTPController.presentViewController(passcodemodal, animated: true, completion: nil)
                }
            }
        })
        }
    }
}
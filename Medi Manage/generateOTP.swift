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
        
        // dropdown list
        
        countryPickerView.delegate = self
        countryCode.inputView = countryPickerView
        countryCode.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(completeProfile.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        countryCode.inputAccessoryView = toolBar
        
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
        
        countryCode.text = countryCodes[1][row]
    }
    func donePicker(){
        countryCode.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
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
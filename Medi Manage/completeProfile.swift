//
//  completeProfile.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 05/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class completeProfile: UIView, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    @IBOutlet var completeProfileMainView: UIView!
    @IBOutlet weak var fullName: UIView!
    @IBOutlet weak var txtFullName: UILabel!
    @IBOutlet weak var txtEmployeeNo: UILabel!
    @IBOutlet weak var txtDateofBirth: UILabel!

    @IBOutlet weak var employeeNumber: UIView!
    @IBOutlet weak var dateOfBirth: UIView!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var maritalStatus: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var profileButton: UIButton!
    var status = ["Married","Single"]
    var codes = ["91","92","93","94"]
    var userDetail : JSON = ""
    
    let maritalPickerView = UIPickerView()
    let codePickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(0, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "completeProfile", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        //statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.addSubview(statusBar)
        
        mobileNumber.delegate = self
        email.delegate = self
        
        // MARITAL STATUS ARROW ICON
        let imageView = UIImageView()
        let image = UIImage(named: "triangle_orange")
        imageView.image = image
        
        let imageView1 = UIImageView()
        let image1 = UIImage(named: "triangle_orange")
        imageView1.image = image1
        
        imageView.frame = CGRect(x: maritalStatus.frame.size.width + 30, y: 20, width: 10, height: 10)
        maritalStatus.addSubview(imageView)
        
        imageView1.frame = CGRect(x: countryCode.frame.size.width + 30, y: 20, width: 10, height: 10)
        countryCode.addSubview(imageView1)
        
        rest.GetProfile({(json:JSON) -> () in
            dispatch_async(dispatch_get_main_queue(),{
                if json == 401 {
                    gCompleteProfileController.redirectToHome()
                }else{
                self.userDetail = json["result"]

            self.txtFullName.text = json["result"]["FullName"].stringValue
            self.txtEmployeeNo.text = json["result"]["EmployeeNumber"].stringValue
            self.txtDateofBirth.text = json["result"]["DateOfBirth"].stringValue
            self.mobileNumber.text = json["result"]["MobileNo"].stringValue
            self.email.text = json["result"]["Email"].stringValue
            self.maritalStatus.text = json["result"]["MaritalStatus"].stringValue
            self.countryCode.text = json["result"]["CountryCode"].stringValue
            if json["result"]["MaritalStatus"].stringValue == "Married"
                {
                    self.maritalPickerView.selectRow(0, inComponent: 0, animated: true)
                }else{
                    self.maritalPickerView.selectRow(1, inComponent: 0, animated: true)
                }
            }
            })
        })
        
        if isVarifiedToEdit
            {
                self.profileButton.setTitle("Submit", forState: .Normal)
                self.mobileNumber.enabled = true
                self.maritalStatus.enabled = true
                self.email.enabled = true
                self.countryCode.enabled = true
            }else{
                self.profileButton.setTitle("Edit", forState: .Normal)
            
                self.mobileNumber.enabled = false
                self.maritalStatus.enabled = false
                self.email.enabled = false
            self.countryCode.enabled = false
            }
        
        // dropdown list
        maritalPickerView.delegate = self
        maritalStatus.inputView = maritalPickerView
        maritalStatus.delegate = self
        
        codePickerView.delegate = self
        countryCode.inputView = codePickerView
        countryCode.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(completeProfile.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        maritalStatus.inputAccessoryView = toolBar
        countryCode.inputAccessoryView = toolBar

        
        completeProfileMainView.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)
    
        //add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: fullName)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: employeeNumber)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: dateOfBirth)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: mobileNumber)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: maritalStatus)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: email)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: countryCode)
       
      
        }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        mobileNumber.resignFirstResponder()
        email.resignFirstResponder()
        return true
    }
    
    @IBAction func closeMe(sender: AnyObject) {
        gCompleteProfileController.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == maritalPickerView{
            return 1
        }else{
            return 2
        }
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == maritalPickerView{
            return status.count
        }else{
            return countryCodes[component].count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == maritalPickerView{
            return status[row]
        }else{
            return countryCodes[0][row]
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == maritalPickerView {
            maritalStatus.text = status[row]
        }else{
            countryCode.text = countryCodes[1][row]
        }
    }
    func donePicker(){
        countryCode.resignFirstResponder()
        maritalStatus.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    
    @IBAction func retrieveLoginCall(sender: AnyObject) {

       
        if profileButton.titleLabel?.text == "Submit" {
            self.userDetail["CountryCode"].stringValue = self.countryCode.text! as String
            self.userDetail["MobileNo"].stringValue = self.mobileNumber.text! as String
            self.userDetail["MaritalStatus"].stringValue = self.maritalStatus.text! as String
            self.userDetail["Email"].stringValue = self.email.text! as String
            print(self.userDetail)
            rest.UpdateProfile(self.userDetail, completion: {(json:JSON) -> () in
                if json == 401 {
                    gCompleteProfileController.redirectToHome()
                }else{
                Popups.SharedInstance.ShowPopup("Validation", message: "Profile is updated.")
                }
            })
            
        }else{
            gCompleteProfileController.performSegueWithIdentifier("requestOTP", sender: nil)
        }
    
    
}
}
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
    
    @IBOutlet weak var countryCodeCode: UITextField!
    @IBOutlet weak var employeeNumber: UIView!
    @IBOutlet weak var dateOfBirth: UIView!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
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
        LoadingOverlay.shared.hideOverlayView()
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        //statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.addSubview(statusBar)
//        LoadingOverlay.shared.showOverlay(gCompleteProfileController.view)
        
        mobileNumber.delegate = self
        email.delegate = self
        password.delegate = self
        
        // MARITAL STATUS ARROW ICON
        let imageView = UIImageView()
        let image = UIImage(named: "triangle_orange")
        imageView.image = image
        
        let imageView1 = UIImageView()
        let image1 = UIImage(named: "triangle_orange")
        imageView1.image = image1
        
        imageView.frame = CGRect(x: maritalStatus.frame.size.width + 30, y: 20, width: 10, height: 10)
        maritalStatus.addSubview(imageView)
        
        imageView1.frame = CGRect(x: countryCodeCode.frame.size.width + 30, y: 20, width: 10, height: 10)
        countryCodeCode.addSubview(imageView1)
        
        let token = defaultToken.stringForKey("access_token")
        print(countryCodes[1].indexOf { $0 == "355" })
        print(token)
        
        if token != nil && token != "null" {
            self.password.hidden = true
            rest.GetProfile({(json:JSON) -> () in
                dispatch_async(dispatch_get_main_queue(),{
                    print(json["result"])
                    LoadingOverlay.shared.hideOverlayView()
                    if json == 401 {
                        gCompleteProfileController.redirectToHome()
                    }else{
                        self.userDetail = json["result"]
//                        self.userDetail["CountryCode"] = "91"
                        self.txtFullName.text = json["result"]["FullName"].stringValue
                        self.txtEmployeeNo.text = json["result"]["EmployeeNumber"].stringValue
                        let fullNameArr1 = json["result"]["DateOfBirth"].stringValue.characters.split{$0 == "T"}.map(String.init)
                        self.txtDateofBirth.text = fullNameArr1[0]
                        self.mobileNumber.text = json["result"]["MobileNo"].stringValue
                        self.email.text = json["result"]["Email"].stringValue
                        self.maritalStatus.text = json["result"]["MaritalStatus"].stringValue
                        if self.userDetail["CountryCode"].stringValue != "" && self.userDetail["CountryCode"] != nil{
                            let a = countryCodes[1].indexOf { $0 == self.userDetail["CountryCode"].stringValue }
                            self.countryCodeCode.text = countryCodes[0][a!]
                        }
                        if json["result"]["MaritalStatus"].stringValue == "Married"
                        {
                            self.maritalPickerView.selectRow(0, inComponent: 0, animated: true)
                        }else{
                            self.maritalPickerView.selectRow(1, inComponent: 0, animated: true)
                        }
                    }
                })
            })
        }else{
            print("in signup")
            
            LoadingOverlay.shared.hideOverlayView()
            self.password.hidden = false
            self.userDetail = signUpUser
            self.txtFullName.text = signUpUser["FullName"].stringValue
            self.txtEmployeeNo.text = signUpUser["EmployeeNumber"].stringValue
            let fullNameArr1 = signUpUser["DateOfBirth"].stringValue.characters.split{$0 == "T"}.map(String.init)
            self.txtDateofBirth.text = fullNameArr1[0]
            self.mobileNumber.text = signUpUser["MobileNo"].stringValue
            self.email.text = signUpUser["Email"].stringValue
            self.maritalStatus.text = signUpUser["MaritalStatus"].stringValue
            if signUpUser["CountryCode"].stringValue != "" && signUpUser["CountryCode"] != nil{
                let a = countryCodes[1].indexOf { $0 == signUpUser["CountryCode"].stringValue }
                self.countryCode.text = countryCodes[0][a!]
            }
            if signUpUser["MaritalStatus"].stringValue == "Married"
            {
                self.maritalPickerView.selectRow(0, inComponent: 0, animated: true)
            }else{
                self.maritalPickerView.selectRow(1, inComponent: 0, animated: true)
            }
        }
        
        
        switch profileState {
        case "Submit":
            self.profileButton.setTitle("Submit", forState: .Normal)
            editSave(true)
            break
        case "Edit":
            self.profileButton.setTitle("Edit", forState: .Normal)
            editSave(false)
            break
        default:
            break
        }
        
        // dropdown list
        maritalPickerView.delegate = self
        maritalStatus.inputView = maritalPickerView
        maritalStatus.delegate = self
        
        codePickerView.delegate = self
        countryCodeCode.inputView = codePickerView
        countryCodeCode.delegate = self
        
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
        countryCodeCode.inputAccessoryView = toolBar
        
        
        completeProfileMainView.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)
        
        //add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: fullName)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: employeeNumber)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: dateOfBirth)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: mobileNumber)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: maritalStatus)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: email)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: countryCodeCode)
        
        
    }
    func editSave(data:Bool) {
        self.mobileNumber.enabled = data
        self.maritalStatus.enabled = data
        self.email.enabled = data
        self.countryCodeCode.enabled = data
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
        return 1
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
            countryCodeCode.text = countryCodes[0][row]
            countryCode.text = countryCodes[1][row]
        }
        
    }
    func donePicker(){
        countryCodeCode.resignFirstResponder()
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
            self.userDetail["Password"].stringValue = self.password.text! as String

            //  LOGIN WITH ENTERED PASSWORD AND USER NAME
            let token = defaultToken.stringForKey("access_token")

            if token != nil && token != "null" {
                rest.UpdateProfile(self.userDetail, completion: {(json:JSON) -> () in
                    dispatch_async(dispatch_get_main_queue(),{
                        print("--------------Update profile user------------------------")
                        print(json)
                        if json == 401 {
                            gCompleteProfileController.redirectToHome()
                        }else{
                            if json["state"]{
                                let dialog = UIAlertController(title: "Profile", message: "Profile Updated successfully!" ,preferredStyle: UIAlertControllerStyle.Alert)
                                
                                dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{
                                    action in
                                    //                                            gCompleteProfileController.dismissViewControllerAnimated(true, completion: nil)
                                    
                                    let vc = gCompleteProfileController.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
                                    
                                    gCompleteProfileController.presentViewController(vc, animated: true, completion: nil)
                                }))
                                gCompleteProfileController.presentViewController(dialog, animated: true, completion: nil)
                            }else{
                                Popups.SharedInstance.ShowPopup("Error Occured", message: json["error_message"].stringValue)
                            }
                        }
                    })
                })
            }else{
            
            print(self.userDetail)
            rest.registerUser(self.userDetail, completion: {(json:JSON) -> () in
                dispatch_async(dispatch_get_main_queue(),{
                    print("--------------Register user------------------------")
                    print(json)
                    if json["state"] {
                    rest.loginAlaomFire(self.userDetail["Email"].stringValue, password: self.userDetail["Password"].stringValue, completion: {(json:JSON) -> () in
                        dispatch_async(dispatch_get_main_queue(),{
                            print("--------------Login------------------------")
                            print(json)
                            LoadingOverlay.shared.hideOverlayView()
                            let i = 1
                            if let error = json["error"].string
                            {
                                let stError :String = String(json ["error"])
                                
                                let dialog = UIAlertController(title: "Login", message: stError, preferredStyle: UIAlertControllerStyle.Alert)
                                
                                dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.Destructive, handler:{action in}))
                                
                                gCompleteProfileController.presentViewController(dialog, animated: true, completion: nil)
                            }
                            else
                            {
                                Employee_API_KEY = String(json["access_token"])
                                let def = NSUserDefaults.standardUserDefaults()
                                def.setObject(Employee_API_KEY, forKey: "access_token")
                                
                                print("before api call")
                                print(self.userDetail)
                                rest.UpdateProfile(self.userDetail, completion: {(json:JSON) -> () in
                                    dispatch_async(dispatch_get_main_queue(),{
                                    print("--------------Update profile user------------------------")
                                    print(json)
                                    if json == 401 {
                                        gCompleteProfileController.redirectToHome()
                                    }else{
                                        if json["state"]{
                                        let dialog = UIAlertController(title: "Profile", message: "Profile Updated successfully!" ,preferredStyle: UIAlertControllerStyle.Alert)
                                        
                                        dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{
                                            action in
//                                            gCompleteProfileController.dismissViewControllerAnimated(true, completion: nil)

                                            let vc = gCompleteProfileController.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarController
                                            
                                            gCompleteProfileController.presentViewController(vc, animated: true, completion: nil)
                                        }))
                                        gCompleteProfileController.presentViewController(dialog, animated: true, completion: nil)
                                        }else{
                                            Popups.SharedInstance.ShowPopup("Error Occured", message: json["error_message"].stringValue)
                                        }
                                    }
                                    })
                                })
                            }
                        })
                    })
                    }else{
                        Popups.SharedInstance.ShowPopup("Error Occured", message: json["error_message"].stringValue.stringByRemovingPercentEncoding!)
                    }
                })
            })
            }
            //  LOGIN WITH ENTERED PASSWORD AND USER NAME
            
        }else{
            let vc = gCompleteProfileController.storyboard?.instantiateViewControllerWithIdentifier("retrieveLogin") as! RetrieveLoginController
            
            gCompleteProfileController.presentViewController(vc, animated: true, completion: nil)
        }
        
        
    }
}
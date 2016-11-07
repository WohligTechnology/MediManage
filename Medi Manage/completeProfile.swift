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
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRect(x: 0, y: myView.frame.size.height - linewidth, width: width - 30, height: linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "completeProfile", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview)
        LoadingOverlay.shared.hideOverlayView()
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
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
        
        let token = defaultToken.string(forKey: "access_token")
        print(countryCodes[1].index { $0 == "355" })
        print(token)
        
        if token != nil && token != "null" {
            self.password.isHidden = true
            rest.GetProfile({(json:JSON) -> () in
                dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
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
                            let a = countryCodes[1].index { $0 == self.userDetail["CountryCode"].stringValue }
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
            self.password.isHidden = false
            self.userDetail = signUpUser
            self.txtFullName.text = signUpUser["FullName"].stringValue
            self.txtEmployeeNo.text = signUpUser["EmployeeNumber"].stringValue
            let fullNameArr1 = signUpUser["DateOfBirth"].stringValue.characters.split{$0 == "T"}.map(String.init)
            self.txtDateofBirth.text = fullNameArr1[0]
            self.mobileNumber.text = signUpUser["MobileNo"].stringValue
            self.email.text = signUpUser["Email"].stringValue
            self.maritalStatus.text = signUpUser["MaritalStatus"].stringValue
            if signUpUser["CountryCode"].stringValue != "" && signUpUser["CountryCode"] != nil{
                let a = countryCodes[1].index { $0 == signUpUser["CountryCode"].stringValue }
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
            self.profileButton.setTitle("Submit", for: UIControlState())
            editSave(true)
            break
        case "Edit":
            self.profileButton.setTitle("Edit", for: UIControlState())
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
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(completeProfile.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        maritalStatus.inputAccessoryView = toolBar
        countryCodeCode.inputAccessoryView = toolBar
        
        
        completeProfileMainView.frame = CGRect(x: 0, y: 20, width: self.frame.size.width, height: self.frame.size.height)
        
        //add borders
        addBottomBorder(UIColor.black, linewidth: 1, myView: fullName)
        addBottomBorder(UIColor.black, linewidth: 1, myView: employeeNumber)
        addBottomBorder(UIColor.black, linewidth: 1, myView: dateOfBirth)
        addBottomBorder(UIColor.black, linewidth: 1, myView: mobileNumber)
        addBottomBorder(UIColor.black, linewidth: 1, myView: maritalStatus)
        addBottomBorder(UIColor.black, linewidth: 1, myView: email)
        addBottomBorder(UIColor.black, linewidth: 1, myView: countryCodeCode)
        
        
    }
    func editSave(_ data:Bool) {
//        self.mobileNumber.enabled = data
//        self.maritalStatus.enabled = data
//        self.email.enabled = data
//        self.countryCodeCode.enabled = data
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mobileNumber.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    @IBAction func closeMe(_ sender: AnyObject) {
        gCompleteProfileController.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == maritalPickerView{
            return status.count
        }else{
            return countryCodes[component].count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == maritalPickerView{
            return status[row]
        }else{
            return countryCodes[0][row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    
    @IBAction func retrieveLoginCall(_ sender: AnyObject) {
        
        
        if profileButton.titleLabel?.text == "Submit" {
            profileButton.titleLabel?.text = "Loading...";
            self.userDetail["CountryCode"].stringValue = self.countryCode.text! as String
            self.userDetail["MobileNo"].stringValue = self.mobileNumber.text! as String
            self.userDetail["MaritalStatus"].stringValue = self.maritalStatus.text! as String
            self.userDetail["Email"].stringValue = self.email.text! as String
            self.userDetail["Password"].stringValue = self.password.text! as String

            //  LOGIN WITH ENTERED PASSWORD AND USER NAME
            let token = defaultToken.string(forKey: "access_token")

            if token != nil && token != "null" {
                rest.UpdateProfile(self.userDetail, completion: {(json:JSON) -> () in
                    dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                        print("--------------Update profile user------------------------")
                        print(json)
                        if json == 401 {
                            gCompleteProfileController.redirectToHome()
                        }else{
                            if json["state"]{
                                let dialog = UIAlertController(title: "Profile", message: "Profile Updated successfully!" ,preferredStyle: UIAlertControllerStyle.alert)
                                
                                dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler:{
                                    action in
                                    //                                            gCompleteProfileController.dismissViewControllerAnimated(true, completion: nil)
                                    
                                    let vc = gCompleteProfileController.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBarController
                                    
                                    gCompleteProfileController.present(vc, animated: true, completion: nil)
                                }))
                                gCompleteProfileController.present(dialog, animated: true, completion: nil)
                            }else{
                                Popups.SharedInstance.ShowPopup("Error Occured", message: json["error_message"].stringValue)
                            }
                        }
                    })
                })
            }else{
            
            print(self.userDetail)
            rest.registerUser(self.userDetail, completion: {(json:JSON) -> () in
                dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                    print("--------------Register user------------------------")
                    print(json)
                    if json["state"] {
                    rest.loginAlaomFire(self.userDetail["Email"].stringValue, password: self.userDetail["Password"].stringValue, completion: {(json:JSON) -> () in
                        dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                            print("--------------Login------------------------")
                            print(json)
                            LoadingOverlay.shared.hideOverlayView()
                            let i = 1
                            if let error = json["error"].string
                            {
                                let stError :String = String(describing: json ["error"])
                                
                                let dialog = UIAlertController(title: "Login", message: stError, preferredStyle: UIAlertControllerStyle.alert)
                                
                                dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.destructive, handler:{action in}))
                                
                                gCompleteProfileController.present(dialog, animated: true, completion: nil)
                            }
                            else
                            {
                                Employee_API_KEY = String(describing: json["access_token"])
                                let def = UserDefaults.standardUserDefaults()
                                def.setObject(Employee_API_KEY, forKey: "access_token")
                                
                                print("before api call")
                                print(self.userDetail)
                                rest.UpdateProfile(self.userDetail, completion: {(json:JSON) -> () in
                                    dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                                    print("--------------Update profile user------------------------")
                                    print(json)
                                    if json == 401 {
                                        gCompleteProfileController.redirectToHome()
                                    }else{
                                        if json["state"]{
                                        let dialog = UIAlertController(title: "Profile", message: "Profile Updated successfully!" ,preferredStyle: UIAlertControllerStyle.alert)
                                        
                                        dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler:{
                                            action in
//                                            gCompleteProfileController.dismissViewControllerAnimated(true, completion: nil)

                                            let vc = gCompleteProfileController.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBarController
                                            
                                            gCompleteProfileController.present(vc, animated: true, completion: nil)
                                        }))
                                        gCompleteProfileController.present(dialog, animated: true, completion: nil)
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
            let vc = gCompleteProfileController.storyboard?.instantiateViewController(withIdentifier: "retrieveLogin") as! RetrieveLoginController
            
            gCompleteProfileController.present(vc, animated: true, completion: nil)
        }
        
        
    }
}

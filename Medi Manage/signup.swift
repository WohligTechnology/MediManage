//
//  signup.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 05/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//


import Foundation
import UIKit
import SwiftyJSON


class signup: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var employeeID: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    let validator = Validator()
    var dateDob = ""
    var datePickerView:UIDatePicker = UIDatePicker()
    var flag : Bool = false
    var count : Int = 0
    
    
    @IBAction func openDate(_ sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    func datePickerValueChanged(_ sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        dateDob = dateFormatter.string(from: sender.date)
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateOfBirth.text = dateFormatter.string(from: sender.date)
        
    }
    
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
        let nib = UINib(nibName: "signup", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview);
//        dateOfBirth.text = "1990-05-19"
//        employeeID.text = "TestBetsol3"
        defaultToken.removeObject(forKey: "access_token")
        
        
        addPadding(15, myView: employeeID)
        addPadding(15, myView: dateOfBirth)
        
        // CALENDER ICON
        let imageView = UIImageView()
        let image = UIImage(named: "calender_black_icon")
        imageView.image = image
        imageView.frame = CGRect(x: dateOfBirth.frame.size.width + 15, y: 15, width: 20, height: 20)
        dateOfBirth.addSubview(imageView)
        
        // dropdown list
        //        datePickerView.delegate
        //        datePickerView.delegate = self
        employeeID.delegate = self
        dateOfBirth.inputView = datePickerView
        dateOfBirth.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(signup.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dateOfBirth.inputAccessoryView = toolBar
        
        
        validator.registerField(employeeID, rules: [RequiredRule(), FullNameRule()])
        
    }
    func donePicker(){
        dateOfBirth.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        employeeID.resignFirstResponder()
        return true
    }
    
    @IBAction func loginCall(_ sender: AnyObject) {
        gSignupController.performSegue(withIdentifier: "login", sender: nil)
    }
    @IBAction func completeProfileCall(_ sender: AnyObject) {
        
        if(employeeID.text == "" || dateOfBirth.text == "")
        {
            Popups.SharedInstance.ShowPopup("Login", message: "Both Fields are Required")
            
        }
        else{
            LoadingOverlay.shared.showOverlay(gSignupController.view)
            
            rest.findEmployee(employeeID.text!, dob: dateDob, completion: {(json:JSON) -> ()in
                dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                        LoadingOverlay.shared.hideOverlayView()
                        print(json)
                        let anotherCharacter: String = (String(describing: json["state"]))
                        switch anotherCharacter {
                        case "true" :
                            signUpUser = json["result"]
                            let dialog = UIAlertController(title: "Welcome", message: "Procced Now ", preferredStyle: UIAlertControllerStyle.alert)
                            
                            
                            dialog.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.destructive, handler:{
                                action in
                                profileState = "Submit"
                                let VC = storyboard?.instantiateViewController(withIdentifier: "completeProfile") as! CompleteProfileController
                                
                                gSignupController.present(VC, animated: true , completion: nil)
                                
                            }))
                            
                            gSignupController.present(dialog, animated: true, completion: nil)
                            
                            
                            break
                        case "false" :
                            let error_msg : String = String(describing: json["error_message"])
                            
                            
                            
                            let dialog = UIAlertController(title: "Sign Up", message: error_msg, preferredStyle: UIAlertControllerStyle.alert)
                            
                            dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.destructive, handler:{
                                action in
//                                self.employeeID.text = ""
                                
                            }))
                            gSignupController.present(dialog, animated: true, completion: nil)
                            
                            break
                            
                        default :
                            
                            break
                        }
                })})   
        }
        
    }
}

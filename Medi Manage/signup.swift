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
//    let validator = Validator()
    var dateDob = ""
    var datePickerView:UIDatePicker = UIDatePicker()
    var flag : Bool = false
    var count : Int = 0
    let date = NSDate()
    var calendar = NSCalendar.currentCalendar()
    var currentYear: Int = 0
    var year: [Int] = []
    
    
    @IBAction func openDate(sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.Date
//        datePickerView.minimumDate = date
//        datePickerView.maximumDate = date
//        datePickerView.maximumDate = NSCalendar.currentCalendar().dateByAddingUnit(.Year, value: 20, toDate: NSDate(), options: [])
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
         dateFormatter.dateFormat = "ddMMyyyy"

//        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//        let components : NSDateComponents = NSDateComponents()
//        components.year = -21
//        components.month = components.month - 1
//        components.day = 1
////        components.month = 0
////        print("\(components.month)")
////         print("\(components.year)")
////        print("\(components.day)")
//        let minDate: NSDate = gregorian.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))!
//        self.datePickerView.minimumDate = minDate
//        components.year = 0
//        components.month = components.month - 12
//        components.day = 31
////        components.month = components.month - 12
//        let maxDate: NSDate = gregorian.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))!
//        self.datePickerView.maximumDate = maxDate
        print("printdate\(currentYear)")
//        for _ in 0..<20{
//           year.append(currentYear)
//            currentYear -= 1
//        }
//        datePickerView.maximumDate = NSCalendar.currentCalendar().dateByAddingUnit(.NSYearCalendarUnit, value: -20, toDate: date, options: [])
//        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
//        let dateFormat = "Monday,Jan 01,1997"
//        let date = dateFormatter.dateFromString(dateFormat)
//        
//        datePickerView.date = date!
        dateDob = dateFormatter.stringFromDate(sender.date)
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateOfBirth.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
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
        let nib = UINib(nibName: "signup", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
//        dateOfBirth.text = "1990-05-19"
//        employeeID.text = "TestBetsol3"
        defaultToken.removeObjectForKey("access_token")
        
        
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
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(signup.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        dateOfBirth.inputAccessoryView = toolBar
        
        
//        validator.registerField(employeeID, rules: [RequiredRule(), FullNameRule()])
        
    }
    func donePicker(){
        dateOfBirth.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        employeeID.resignFirstResponder()
        return true
    }
    
    @IBAction func loginCall(sender: AnyObject) {
        gSignupController.performSegueWithIdentifier("login", sender: nil)
    }
    @IBAction func completeProfileCall(sender: AnyObject) {
        
        if(employeeID.text == "" || dateOfBirth.text == "")
        {
            Popups.SharedInstance.ShowPopup("Login", message: "Both Fields are Required")
            
        }
        else{
            LoadingOverlay.shared.showOverlay(gSignupController.view)
            
            rest.findEmployee(employeeID.text!, dob: dateDob, completion: {(json:JSON) -> ()in
                dispatch_async(dispatch_get_main_queue(),
                    {
                        LoadingOverlay.shared.hideOverlayView()
                        print(json)
                        let anotherCharacter: String = (String(json["state"]))
                        switch anotherCharacter {
                        case "true" :
                            signUpUser = json["result"]
                            let dialog = UIAlertController(title: "Welcome", message: "Proceed Now ", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            
                            dialog.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Destructive, handler:{
                                action in
                                profileState = "Submit"
                                let VC = storyboard?.instantiateViewControllerWithIdentifier("completeProfile") as! CompleteProfileController
                                
                                gSignupController.presentViewController(VC, animated: true , completion: nil)
                                
                            }))
                            
                            gSignupController.presentViewController(dialog, animated: true, completion: nil)
                            
                            
                            break
                        case "false" :
                            
                            
                            let error_msg : String = String(json["error_message"])
                            
                            
                            
                            let dialog = UIAlertController(title: "Sign Up", message: error_msg, preferredStyle: UIAlertControllerStyle.Alert)
                            
                            dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.Destructive, handler:{
                                action in
//                                self.employeeID.text = ""
                                
                            }))
                            gSignupController.presentViewController(dialog, animated: true, completion: nil)
                            
                            break
                            
                        default :
                            
                            break
                        }
                })})   
        }
        
    }
}

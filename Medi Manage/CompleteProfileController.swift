//
//  CompleteProfileController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gCompleteProfileController: UIViewController!



class CompleteProfileController: UIViewController {

//    @IBOutlet var completeProfileMainView: UIView!
//    @IBOutlet weak var fullName: UIView!
//    @IBOutlet weak var txtFullName: UILabel!
//    @IBOutlet weak var txtEmployeeNo: UILabel!
//    @IBOutlet weak var txtDateofBirth: UILabel!
//    
//    @IBOutlet weak var profileButton: UIButton!
//    @IBOutlet weak var employeeNumber: UIView!
//    @IBOutlet weak var dateOfBirth: UIView!
//    @IBOutlet weak var mobileNumber: UITextField!
//    @IBOutlet weak var maritalStatus: UITextField!
//    @IBOutlet weak var email: UITextField!
//    @IBOutlet weak var password: UITextField!
//    var status = ["Married","Single"]
    
    let pickerView = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        gCompleteProfileController = self
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        //statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        // dropdown list
//        pickerView.delegate = self
//        maritalStatus.inputView = pickerView
//        maritalStatus.delegate = self
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.Default
//        toolBar.translucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CompleteProfileController.donePicker))
//        
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        
//        toolBar.setItems([spaceButton, doneButton], animated: false)
//        toolBar.userInteractionEnabled = true
//        
//        maritalStatus.inputAccessoryView = toolBar
        
        
        // MARITAL STATUS ARROW ICON
//        let imageView = UIImageView()
//        let image = UIImage(named: "triangle_orange")
//        imageView.image = image
//        imageView.frame = CGRect(x: maritalStatus.frame.size.width + 30, y: 20, width: 10, height: 10)
//        maritalStatus.addSubview(imageView)
        
//        rest.GetProfile({(json:JSON) -> () in
//            dispatch_async(dispatch_get_main_queue(),{
//
//            print(json)
//            self.txtFullName.text = json["result"]["FullName"].stringValue
//            self.txtEmployeeNo.text = json["result"]["EmployeeNumber"].stringValue
//            self.txtDateofBirth.text = json["result"]["DateOfBirth"].stringValue
//            self.mobileNumber.text = json["result"]["MobileNo"].stringValue
//            self.email.text = json["result"]["Email"].stringValue
//            self.maritalStatus.text = json["result"]["MaritalStatus"].stringValue
//            if json["result"]["MaritalStatus"].stringValue == "Married" {
//                self.pickerView.selectRow(0, inComponent: 0, animated: true)
//            }else{
//                self.pickerView.selectRow(1, inComponent: 0, animated: true)
//            }
//            })
//            
//            
//        })
//        if isVarifiedToEdit {
//            self.profileButton.setTitle("Submit", forState: .Normal)
//            self.mobileNumber.enabled = true
//            self.maritalStatus.enabled = true
//            self.email.enabled = true
//        }else{
//            self.profileButton.setTitle("Edit", forState: .Normal)
//
//            self.mobileNumber.enabled = false
//            self.maritalStatus.enabled = false
//            self.email.enabled = false
//        }        //add borders
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: fullName)
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: employeeNumber)
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: dateOfBirth)
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: mobileNumber)
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: maritalStatus)
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: email)
//        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: password)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(0, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return status.count
//    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return status[row]
//    }
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        maritalStatus.text = status[row]
//    }
//    func donePicker(){
//        maritalStatus.resignFirstResponder()
//    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }

    @IBAction func editProfile(sender: AnyObject) {
        print(isVarifiedToEdit)
        self.performSegueWithIdentifier("requestOTP", sender: nil)
    }
    
}

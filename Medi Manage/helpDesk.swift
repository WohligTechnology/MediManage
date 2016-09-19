//
//  helpDesk.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class helpDesk: UIView, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var helpDeskMainView: UIView!
    
    let pickerView = UIPickerView()
    
    @IBOutlet weak var typeQuestionField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var submitQueryButton: UIButton!
    
    var categories : JSON = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
//        if((gHelpDeskFAQController) != nil) {
//            gHelpDeskFAQController.dismissViewControllerAnimated(false, completion: nil)
//        }
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
        let nib = UINib(nibName: "helpDesk", bundle: bundle)
        let helpDesk = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDesk.frame = bounds
        helpDesk.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDesk)
        
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.addSubview(mainsubHeader)
        
        helpDeskMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height)
        
        //get faq data
        rest.FaqCategories({(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue()){
                if json == 401 {
                    gHelpDeskController.redirectToHome()
                }else{
                    print(json)
                    LoadingOverlay.shared.hideOverlayView()
                    if json["state"] {
                        if json["result"].count == 0 {
                            Popups.SharedInstance.ShowPopup("Category", message: "No Categories Found")
                            self.typeQuestionField.enabled = false
                        }else{
                        self.categories = json["result"]
                            self.typeQuestionField.enabled = true
                        }
                    }
                }
            }
        })
        
        // dropdown list
        pickerView.delegate = self
        typeQuestionField.inputView = pickerView
        typeQuestionField.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        typeQuestionField.inputAccessoryView = toolBar
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: typeQuestionField)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]["CategoryName"].stringValue
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeQuestionField.text = categories[row]["CategoryName"].stringValue
        categoryId = categories[row]["ID"].stringValue
    }
    func donePicker(){
        typeQuestionField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    @IBAction func selectCategory(sender: AnyObject) {
        
        
    }
    @IBAction func helpDeskFAQCall(sender: AnyObject) {
        print("submit clicked")
        if self.categories.count == 0 {
            Popups.SharedInstance.ShowPopup("Category", message: "No Categories Found")
        }else{
        if typeQuestionField.text == "" {
            Popups.SharedInstance.ShowPopup("Category", message: "Please Select Category.")
            
        }else{
            gHelpDeskController.performSegueWithIdentifier("helpDeskToHelpDeskFAQ", sender: nil)
        }
        }
    }
    @IBAction func submitQry(sender: AnyObject) {
        gHelpDeskController.performSegueWithIdentifier("sendquery", sender: nil)
    }
    
}

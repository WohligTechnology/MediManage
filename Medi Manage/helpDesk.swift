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
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRect(x: 0, y: myView.frame.size.height - linewidth, width: width - 30, height: linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "helpDesk", bundle: bundle)
        let helpDesk = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        helpDesk.frame = bounds
        helpDesk.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(helpDesk)
        
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 60, width: width, height: 50))
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.addSubview(mainsubHeader)
        
        helpDeskMainView.frame = CGRect(x: 0, y: 120, width: self.frame.size.width, height: self.frame.size.height)
        
        //get faq data
        rest.FaqCategories({(json:JSON) -> () in
            dispatch_get_main_queue().sync(DispatchQueue.main){
                if json == 401 {
                    gHelpDeskController.redirectToHome()
                }else{
                    print(json)
                    LoadingOverlay.shared.hideOverlayView()
                    if json["state"] {
                        if json["result"].count == 0 {
                            Popups.SharedInstance.ShowPopup("Category", message: "No Categories Found")
                            self.typeQuestionField.isEnabled = false
                        }else{
                        self.categories = json["result"]
                            self.typeQuestionField.isEnabled = true
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
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black

        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(helpDesk.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        typeQuestionField.inputAccessoryView = toolBar
        
        // add borders
        addBottomBorder(UIColor.black, linewidth: 1, myView: typeQuestionField)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]["CategoryName"].stringValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeQuestionField.text = categories[row]["CategoryName"].stringValue
        categoryId = categories[row]["ID"].stringValue
    }
    func donePicker(){
        typeQuestionField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    @IBAction func selectCategory(_ sender: AnyObject) {
        
        
    }
    @IBAction func helpDeskFAQCall(_ sender: AnyObject) {
        print("submit clicked")
        if self.categories.count == 0 {
            Popups.SharedInstance.ShowPopup("Category", message: "No Categories Found")
        }else{
        if typeQuestionField.text == "" {
            Popups.SharedInstance.ShowPopup("Category", message: "Please Select Category.")
            
        }else{
            gHelpDeskController.performSegue(withIdentifier: "helpDeskToHelpDeskFAQ", sender: nil)
        }
        }
    }
    @IBAction func submitQry(_ sender: AnyObject) {
        gHelpDeskController.performSegue(withIdentifier: "sendquery", sender: nil)
    }

}


//
//  helpDeskQuery.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON
import QToasterSwift

class helpDeskQuery: UIView, UITextFieldDelegate {
    
    @IBOutlet var helpDeskQueryMainView: UIView!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var queryTextField: UITextField!
    var to = ""
    
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
        border.frame = CGRectMake(-5, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "helpDeskQuery", bundle: bundle)
        let helpDeskQuery = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDeskQuery.frame = bounds
        helpDeskQuery.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDeskQuery)
        
        
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 0, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_four")
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.addSubview(mainsubHeader)
        subjectTextField.delegate = self
        queryTextField.delegate = self
        
        //Connection Details
        rest.ConnectDetails({(json:JSON) -> ()  in
            print(json)
            if json == 401 {
                gHelpDeskQueryController.redirectToHome()
            }else{
            self.to = json["result"]["QueriesEmail"].stringValue
            }
        })
        
        helpDeskQueryMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 75)
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: subjectTextField)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: queryTextField)
        
    }
//    override func resignFirstResponder() -> Bool {
//        <#code#>
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        subjectTextField.resignFirstResponder()
        queryTextField.resignFirstResponder()
        return true
    }
    
    func popMe(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        gHelpDeskQueryController.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func connectCall(sender: AnyObject) {
        subjectTextField.resignFirstResponder()
        queryTextField.resignFirstResponder()
        if self.subjectTextField.text != "" && self.queryTextField.text != "" {
            let params = "{\"To\":\(to),\"Subject\":\(self.subjectTextField.text! as String),\"Body\":\(self.queryTextField.text! as String)}"
            rest.SendQuery(JSON(params), completion: {(json:JSON) -> () in
                print(json)
                if json == 401 {
                    gHelpDeskQueryController.redirectToHome()
                }else{
                if json["state"] {
                    let alert = UIAlertController(title: "Validation", message: "Query submited sucessfully", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    gHelpDeskQueryController.presentViewController(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Validation", message: json["error_message"].stringValue, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    gHelpDeskQueryController.presentViewController(alert, animated: true, completion: nil)
                }
            }
            })
        }else{
            let alert = UIAlertController(title: "Validation", message: "Enter all Fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            gHelpDeskQueryController.presentViewController(alert, animated: true, completion: nil)
        }
    }

}

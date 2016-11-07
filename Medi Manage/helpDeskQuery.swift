//
//  helpDeskQuery.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: -5, y: myView.frame.size.height - linewidth, width: width - 30, height: linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "helpDeskQuery", bundle: bundle)
        let helpDeskQuery = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        helpDeskQuery.frame = bounds
        helpDeskQuery.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(helpDeskQuery)
        
        
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 0, width: width, height: 50))
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
        
        helpDeskQueryMainView.frame = CGRect(x: 0, y: 70, width: self.frame.size.width, height: self.frame.size.height - 75)
        
        // add borders
        addBottomBorder(UIColor.black, linewidth: 0.5, myView: subjectTextField)
        addBottomBorder(UIColor.black, linewidth: 0.5, myView: queryTextField)
        
    }
//    override func resignFirstResponder() -> Bool {
//        <#code#>
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        subjectTextField.resignFirstResponder()
        queryTextField.resignFirstResponder()
        return true
    }
    
    func popMe(_ title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        gHelpDeskQueryController.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func connectCall(_ sender: AnyObject) {
        subjectTextField.resignFirstResponder()
        queryTextField.resignFirstResponder()
        if self.subjectTextField.text != "" && self.queryTextField.text != "" {
//            let params = "{\"To\":\(to),\"Subject\":\(self.subjectTextField.text! as String),\"Body\":\(self.queryTextField.text! as String)}"
            let params = ["To": to,"Subject":self.subjectTextField.text! as String, "Body":self.queryTextField.text! as String]
            rest.SendQuery(JSON(params), completion: {(json:JSON) -> () in
                print(json)
                if json == 401 {
                    gHelpDeskQueryController.redirectToHome()
                }else{
                if json["state"] {
                    let alert = UIAlertController(title: "Validation", message: "Query submited sucessfully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    gHelpDeskQueryController.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Validation", message: json["error_message"].stringValue, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    gHelpDeskQueryController.present(alert, animated: true, completion: nil)
                }
            }
            })
        }else{
            let alert = UIAlertController(title: "Validation", message: "Enter all Fields.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            gHelpDeskQueryController.present(alert, animated: true, completion: nil)
        }
    }

}

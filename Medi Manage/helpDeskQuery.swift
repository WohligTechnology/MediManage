//
//  helpDeskQuery.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class helpDeskQuery: UIView {
    
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
        
        //Connection Details
        rest.ConnectDetails({(json:JSON) -> ()  in
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
    @IBAction func connectCall(sender: AnyObject) {
        
        if self.subjectTextField.text != "" && self.queryTextField.text != "" {
            let params = "{\"To\":\"jagruti@wohlig.com\",\"Subject\":\(self.subjectTextField.text! as String),\"Body\":\(self.queryTextField.text! as String)}"
            print(String(params))
            rest.SendQuery(JSON(params), completion: {(json:JSON) -> () in
                if json == 401 {
                    gHelpDeskQueryController.redirectToHome()
                }else{
                if json["state"] {
                    Popups.SharedInstance.ShowPopup("Validation", message: "Query submited sucessfully")
                }else{
                    Popups.SharedInstance.ShowPopup("Validation", message: "Can not send Query")
                }
            }
            })
        }else{
            Popups.SharedInstance.ShowPopup("Validation", message: "Enter all Fields.")

        }
//        gHelpDeskQueryController.performSegueWithIdentifier("helpDeskQueryToConnect", sender: nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  ComposeMessageController.swift
//  MediManage
//
//  Created by Pranay Joshi on 15/11/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class ComposeMessageController: UIViewController {
    var subjectMessage:String! = ""
    var inboxMessage: JSON! = []
    var inboxPatient: JSON! = []
    var subjectId: JSON! = []
    var composeTo = ""
    var reimburseEmail: JSON! = []
    
    @IBOutlet var messageTextView: UIView!
    
    @IBOutlet weak var message1: UITextView!
    
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var subjectText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navshow()
        message1.layer.borderWidth = 1.0
        message1.layer.borderColor = UIColor.blackColor().CGColor
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainSubHeader.subHeaderTitle.text = "INBOX"
        mainSubHeader.subHeaderIcon.image = UIImage(named: "inbox")
        self.view.addSubview(mainSubHeader)
        rest.ConnectDetails({(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue(),{
                if json == 401 {
                    self.redirectToHome()
                }else{
                    print(json)
                    self.reimburseEmail = json
                    self.composeTo = self.reimburseEmail["result"]["ReimbursementEmail"].stringValue
                }
                })
            })
    

        
        rest.messageReimburse({(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue(),{
                if json == 401 {
                    self.redirectToHome()
                }else{
                    print(json)
                    self.inboxMessage = json
                    message = self.inboxMessage
                    self.inboxPatient = self.inboxMessage["result"]["Patients"]
                    //subjectMessage = "Reimbursement Claim Update - \(inboxPatient[1]["ID"].int)"
                    //print(inboxPatient[0]["ID"].int)
                    self.subjectText.text = "Reimbursement Claim No - \(oneJson["PATNo"].stringValue)"
                    //self.clientName.text = message["result"]["ClientName"].stringValue
                    print("\(message["result"]["ClientName"].stringValue)")
                    self.message1.text = ("Hi,\n\nI have some queries regarding my claim number \(oneJson["PATNo"].stringValue).The details of my query are as per below.\n\n\n\nThanks & Regards,\nEmployeeName: \(message["result"]["EmployeeName"].stringValue)\nCorporateName: \(message["result"]["ClientName"].stringValue)\nEmployee ID: \(message["result"]["EmpID"])\nEmail ID: \(message["result"]["EmployeeEmail"])")
                }
            })
        })
        subjectId = oneJson
        message = inboxMessage
        //inboxPatient = inboxMessage["result"]["Patients"]
         //subjectMessage = "Reimbursement Claim Update - \(inboxPatient[1]["ID"].int)"
        //print(inboxPatient[0]["ID"].int)
        //subjectText.text = "Reimbursement Claim No - \(oneJson["PATNo"].stringValue)"
       // clientName.text = message["result"]["ClientName"].stringValue
      //  print("\(message["result"]["ClientName"].stringValue)")
        // Do any additional setup after loading the view.
    }

    @IBAction func submitMessage(sender: UIButton) {
        subjectText.resignFirstResponder()
        message1.resignFirstResponder()
        if self.subjectText.text != "" && self.message1.text != "" {
            //            let params = "{\"To\":\(to),\"Subject\":\(self.subjectTextField.text! as String),\"Body\":\(self.queryTextField.text! as String)}"
            let params = ["To": composeTo as String, "Subject":self.subjectText.text! as String, "Body":self.message1.text! as String]
            rest.SendQuery(JSON(params), completion: {(json:JSON) -> () in
                print(json)
                if json == 401 {
                    gHelpDeskQueryController.redirectToHome()
                }else{
                    if json["state"] {
                        let alert = UIAlertController(title: "Validation", message: "Query submited sucessfully", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }else{
                        let alert = UIAlertController(title: "Validation", message: json["error_message"].stringValue, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            })
        }else{
            let alert = UIAlertController(title: "Validation", message: "Enter all Fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

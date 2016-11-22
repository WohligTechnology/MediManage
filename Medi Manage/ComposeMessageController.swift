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
    var inboxMessage: JSON!
    var inboxPatient: JSON!
    
    @IBOutlet weak var subjectText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navshow()
       
        
        let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainSubHeader.subHeaderTitle.text = "INBOX"
        mainSubHeader.subHeaderIcon.image = UIImage(named: "inbox")
        self.view.addSubview(mainSubHeader)

        rest.messageReimburse({(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue(),{
                if json == 401 {
                    self.redirectToHome()
                }else{
                    print(json)
                    self.inboxMessage = json
                }
                })
        })
        inboxPatient = inboxMessage!["result"]["Patients"]
         subjectMessage = "Reimbursement Claim Update - \(inboxPatient[0]["ID"].int)"
        subjectText.text = subjectMessage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

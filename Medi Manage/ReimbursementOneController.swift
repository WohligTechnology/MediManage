//
//  ReimbursementOneController.swift
//  MediManage
//
//  Created by Pranay Joshi on 12/11/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON
class ReimbursementOneController: UIViewController,UIScrollViewDelegate {
    var claimsJSON: JSON!
    var closedClaimsJSON: JSON!
    var pendingClaimJSON: JSON!
    var personJson : JSON! = []
    var status1:String! = ""
    var status2:String! = ""
    var status3:String! = ""
    var status4:String! = ""
    var mainStatusChange = NSDateFormatter()
    var mainStatusLabelDate:String! = ""
    var mainStatusLabel:String! = ""
    @IBOutlet weak var claimNo: UILabel!
    var name:String! = ""
    var id:String! = ""
    var amount:String! = ""
    @IBOutlet weak var claimNoHide: UILabel!
  
    @IBOutlet weak var preAuthorizationhide: UILabel!
    
    @IBOutlet weak var s5Label2: UILabel!
    @IBOutlet weak var s5Labe1: UILabel!
    @IBOutlet weak var statusFourth: UILabel!
    
        @IBOutlet weak var thirdStatus: UILabel!
    @IBOutlet weak var secondStatus: UILabel!
    @IBOutlet weak var firstStatus: UILabel!
    @IBOutlet weak var status1Label2: UILabel!
    
  
    @IBOutlet weak var sMLabel3: UILabel!
    @IBOutlet weak var sMLabel2: UILabel!
    @IBOutlet weak var sMLable1: UILabel!
    @IBOutlet weak var mainStatusHide: UIImageView!
    @IBOutlet weak var s3Label2: UILabel!
    @IBOutlet weak var s3Label1: UILabel!
    @IBOutlet weak var s2Label2: UILabel!
    @IBOutlet weak var s2label1: UILabel!
    @IBOutlet weak var status1Label1: UILabel!
    @IBOutlet weak var mainStatus: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var patientNameReimburse: UILabel!
    @IBOutlet weak var reimbursementOneScroll: UIScrollView!
    
    @IBOutlet weak var hideStatus: UIImageView!
  
    @IBOutlet weak var hideCall: UIImageView!
    @IBOutlet weak var pendingStatus: UIImageView!
    @IBOutlet weak var queryStatus: UIImageView!
    
   
    @IBOutlet weak var RequestRecdeivedStatus: UIImageView!
    @IBOutlet weak var requestedAmountReimburseOne: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reimbursementOneScroll.contentSize.height = 667
        reimbursementOneScroll.contentSize.width = 375
        reimbursementOneScroll.minimumZoomScale = 0.03
        reimbursementOneScroll.maximumZoomScale = 1.0
        navshow()
        print("personJson ")
        print(personJson)
//      mainStatusLabelDate = personJson["PendingClaims"][0]["ClaimsStatus"][0]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
       // var change = NSDateFormatter()
       // change.dateFormat = "dd-MM-yyyy"
      
      //var  change2 = change.dateFromString(change1)
        
        nameLabel.text = personJson["PatientName"].stringValue
       idLabel.text = personJson["PATNo"].stringValue
        amountLabel.text = ("Rs. \(personJson["ApprovedAmount"].stringValue)")
        if personJson["ClaimsStatus"][0] != nil{
        firstStatus.text = personJson["ClaimsStatus"][0]["Status"].stringValue
            var change1 = personJson["ClaimsStatus"][0]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            status1Label1.text = change1[0]
            status1Label2.text = change1[1]

        }else {
            RequestRecdeivedStatus.alpha = 0
            status1Label1.alpha = 0
            status1Label2.alpha = 0
        }
        if personJson["ClaimsStatus"][1]["Status"] != nil{
        secondStatus.text = personJson["ClaimsStatus"][1]["Status"].stringValue
            var change1 = personJson["ClaimsStatus"][1]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            s2label1.text = change1[0]
            s2Label2.text = change1[1]

        }else {
            queryStatus.alpha = 0
            s2label1.alpha = 0
            s2Label2.alpha = 0
        }
        if personJson["ClaimsStatus"][2]["Status"] != nil{
        thirdStatus.text = personJson["ClaimsStatus"][2]["Status"].stringValue
            var change1 = personJson["ClaimsStatus"][2]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            s3Label1.text = change1[0]
            s3Label2.text = change1[1]

        }else{
            pendingStatus.alpha = 0
            s3Label1.alpha = 0
            s3Label2.alpha = 0
        }
        if personJson["ClaimsStatus"][3]["Status"] != nil{
        statusFourth.text = personJson["ClaimsStatus"][3]["Status"].stringValue
            var change1 = personJson["ClaimsStatus"][3]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            s5Labe1.text = change1[0]
            s5Label2.text = change1[1]

        }else{
            hideStatus.alpha = 0
            s5Labe1.alpha = 0
            s5Label2.alpha = 0
            
        }
        if personJson["Status"] != nil {
        mainStatus.text = personJson["Status"].stringValue
            var change1 = personJson["SettledDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            sMLabel2.text = change1[0]
            sMLabel3.text = change1[1]

        }else {
            mainStatusHide.alpha = 0
            sMLabel2.alpha = 0
            sMLabel3.alpha = 0
            sMLable1.alpha = 0
        }
//        var a = mainStatusLabelDate!.characters.split{$0 == "T"}.map(String.init)
      //  print(mainStatusLabelDate)
//        mainStatusDate.text = a[0]
       // let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        //mainSubHeader.subHeaderTitle.text = "REIMURSEMENT CLAIM"
        //mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        //self.view.addSubview(mainSubHeader)
       // patientNameReimburse.text = name
        func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
            let border = CALayer()
            border.backgroundColor = color.CGColor
            //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
            border.frame = CGRectMake(-4, myView.frame.size.height + 2 - linewidth, width - 30, linewidth)
            myView.layer.addSublayer(border)
        }
        addBottomBorder(UIColor.lightGrayColor(), linewidth: 0.5, myView: patientNameReimburse)
        addBottomBorder(UIColor.darkGrayColor(), linewidth: 0.5, myView: claimNo)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: requestedAmountReimburseOne)
         addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: preAuthorizationhide)
        if myClaim == 0 {
            if activeClaim == 0 {
                
                
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                claimNoHide.alpha = 0
            } else {
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                claimNoHide.alpha = 0
            }
        }
        if myClaim == 1 {
            if activeClaim == 0 {
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                hideCall.alpha = 0
                preAuthorizationhide.alpha = 0
            }else{
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                hideCall.alpha = 0
                preAuthorizationhide.alpha = 0
                
            }
        }
        
    }
    
    
  /*  @IBAction func knowMoreButton(sender: UIButton) {
        let nextViewController: newDemoViewController = mainStoryboard.instantiateViewControllerWithIdentifier("knowMore") as! newDemoViewController
        prepareForSegue(newDemo", sender: self)
        

    }*/

    
       
    @IBAction func knowButton(sender: AnyObject) {
        
        
        oneJson = personJson
        
        
    }
    /*func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "KnowMore" {
                let controller1 = segue.destinationViewController as! newDemoViewController
                if activeClaim == 0 {
                    controller1.continueJson = claimsJSON["result"]["PendingClaims"][preAuthOne]
                    
                }else{
                    controller1.continueJson = claimsJSON["result"]["closedClaims"][preAuthOne]
                    
                }
                
                
            }
        }
    }
    func button() {
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "KnowMore" {
            let controller1 = segue.destinationViewController as! newDemoViewController
            if activeClaim == 0 {
                controller1.continueJson = claimsJSON["result"]["PendingClaims"][preAuthOne]
               
            }else{
                controller1.continueJson = claimsJSON["result"]["closedClaims"][preAuthOne]
                
            }
            
    
                  }
    }*/
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

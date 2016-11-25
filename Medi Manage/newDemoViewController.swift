//
//  newDemoViewController.swift
//  MediManage
//
//  Created by Pranay Joshi on 22/11/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class newDemoViewController: UIViewController {
    var continueJson: JSON! = []
   
    var amountReimburseTwo:String = ""
    var AdmissionTwoString = ""
    var claimsJSON: JSON!
    var closedClaimsJSON: JSON!
    var pendingClaimJSON: JSON!
    var nameReimburseTwo: String = ""
    var connectNumberJSON: JSON! = []
    @IBOutlet weak var nameTwo: UILabel!
    @IBOutlet weak var remarkHide: UILabel!
  
    @IBOutlet weak var claimSupport: UILabel!
    
    @IBOutlet weak var billsHide: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var ss2Label1: UILabel!
    @IBOutlet weak var ss2Status2: UILabel!
    @IBOutlet weak var ss3Status3: UILabel!
    @IBOutlet weak var ss1Label2: UILabel!
    @IBOutlet weak var ss4Image: UIImageView!
    @IBOutlet weak var ss4Status: UILabel!
    @IBOutlet weak var ss5Image: UIImageView!
    @IBOutlet weak var ss4Label1: UILabel!
    @IBOutlet weak var ss5Stat: UILabel!
    @IBOutlet weak var ss5Label1: UILabel!
    @IBOutlet weak var ss5Label2: UILabel!
    @IBOutlet weak var ss4Label2: UILabel!
    @IBOutlet weak var ss1Label1: UILabel!
    @IBOutlet weak var ss3Label2: UILabel!
    @IBOutlet weak var ss3Label1: UILabel!
    @IBOutlet weak var ss1First1: UILabel!
    @IBOutlet weak var ss2Label2: UILabel!
    @IBOutlet weak var preAuthorizationTwohide: UILabel!
    @IBOutlet weak var admissionTwo: UILabel!
    @IBOutlet weak var amountTwo: UILabel!
    @IBOutlet weak var noTwo: UILabel!
  
    @IBOutlet weak var number1: UIButton!
   
    @IBOutlet weak var patientNameReimburseTwo: UILabel!
    
    @IBOutlet weak var claimNoReimburseTwo: UILabel!
    
    @IBOutlet weak var dateofAdmissionReimburseTwo: UILabel!
    
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var requestReceivedImage: UIImageView!
    @IBOutlet weak var requestedAmountReimburseTwo: UILabel!
    
    @IBOutlet weak var claimNo2Hide: UILabel!
    
    @IBOutlet weak var callLabel1: UILabel!
       @IBOutlet weak var pendingImage: UIImageView!
    
    @IBOutlet weak var callLabel2: UILabel!
  
    
    @IBOutlet weak var hidePopup: UIButton!
    @IBOutlet weak var settledImage: UIImageView!
    @IBOutlet weak var reimburseTwoScroll: UIScrollView!
    
     @IBOutlet weak var reimburseView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reimburseTwoScroll.contentSize.height = 667
        reimburseTwoScroll.contentSize.width = 375
        reimburseTwoScroll.minimumZoomScale = 0.03
        reimburseTwoScroll.maximumZoomScale = 1.0
        self.popupView.alpha = 0
        self.reimburseView.alpha = 1
        popupView.layer.masksToBounds = true
        self.popupView.alpha = 0
        navshow()
        func changeDateFormat(givenFormat: String, getFormat: String, givenDate: String, isDate: Bool) -> String {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = givenFormat
            let date = dateFormatter.dateFromString(givenDate)
            print("date : \(givenDate)")
            dateFormatter.dateFormat = getFormat
            if isDate {
                //nothing
            }
            let goodDate = dateFormatter.stringFromDate(date!)
            print("date : \(date)")
            return goodDate
        }
        

        print("))))))))))))))))))))))")
        print(oneJson)
                nameTwo.text = oneJson["PatientName"].stringValue
        noTwo.text = oneJson["PATNo"].stringValue
        amountTwo.text = "Rs.\(oneJson["ApprovedAmount"].stringValue)"
        //noTwo.text = "Rs.\(continueJson["PATNo"].stringValue)"
        print("\(continueJson["ApprovedAmount"].stringValue)")
               if oneJson["ClaimsStatus"][1]["Remark"] != nil {
            //nothing
        }else {
            remarkHide.alpha = 0
            billsHide.alpha = 0
        }
        
        
        if oneJson["ClaimsStatus"][0]["Status"] != nil{
            ss2Status2.text = oneJson["ClaimsStatus"][0]["Status"].stringValue
            var change = oneJson["ClaimsStatus"][0]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
            var date = dateFormatter.dateFromString(change[0])

            ss2Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][0]["ClaimDate"].stringValue, isDate: true)
            ss2Label2.text = change[1]
            ss2Status2.layer.zPosition = 20
            let line = drawDottedLine(frame: CGRectMake(55, 175, 1.5, 80))
            line.backgroundColor = UIColor.clearColor()
            requestReceivedImage.layer.zPosition = 10
        settledImage.layer.zPosition = 10
            pendingImage.layer.zPosition = 10
            ss4Image.layer.zPosition = 10
            ss5Image.layer.zPosition = 10
            reimburseView.addSubview(line)
            

            
        }else {
            settledImage.alpha = 0
            ss2Label1.alpha = 0
            ss2Status2.alpha = 0
        }
        if oneJson["ClaimsStatus"][1]["Status"] != nil{
            ss3Status3.text = oneJson["ClaimsStatus"][1]["Status"].stringValue
            ss3Status3.layer.zPosition = 20
            var change1 = oneJson["ClaimsStatus"][1]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            ss3Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][1]["ClaimDate"].stringValue, isDate: true)
            ss3Label2.text = change1[1]
            let line = drawDottedLine(frame: CGRectMake(55, 175, 1.5, 150))
            line.backgroundColor = UIColor.clearColor()
            requestReceivedImage.layer.zPosition = 10
            settledImage.layer.zPosition = 10
            pendingImage.layer.zPosition = 10
            ss4Image.layer.zPosition = 10
            ss5Image.layer.zPosition = 10
            reimburseView.addSubview(line)
            

            
        }else {
           pendingImage.alpha = 0
            ss3Label1.alpha = 0
            ss3Label2.alpha = 0
        }
        if oneJson["ClaimsStatus"][2]["Status"] != nil{
            ss4Status.text = oneJson["ClaimsStatus"][2]["Status"].stringValue
            ss4Status.layer.zPosition = 20
            var change1 = oneJson["ClaimsStatus"][2]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
            var date = dateFormatter.dateFromString(change1[0])
            

            ss4Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][2]["ClaimDate"].stringValue, isDate: true)
            ss4Label2.text = change1[1]
            let line = drawDottedLine(frame: CGRectMake(55, 175, 1.5, 250))
            line.backgroundColor = UIColor.clearColor()
            requestReceivedImage.layer.zPosition = 10
            settledImage.layer.zPosition = 10
            pendingImage.layer.zPosition = 10
            ss4Image.layer.zPosition = 10
            ss5Image.layer.zPosition = 10
            reimburseView.addSubview(line)

            
        }else{
            ss4Image.alpha = 0
            ss4Label1.alpha = 0
            ss4Label2.alpha = 0
            
        }
        if oneJson["ClaimsStatus"][3]["Status"] != nil{
            ss5Stat.text = oneJson["ClaimsStatus"][3]["Status"].stringValue
            ss5Stat.layer.zPosition = 20
            var change = oneJson["ClaimsStatus"][3]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
            var date1 = dateFormatter.dateFromString(change[0])
            print(change[0])
            print(date1)
          ss5Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][3]["ClaimDate"].stringValue, isDate: true)
            ss5Label2.text = change[1]
            let line = drawDottedLine(frame: CGRectMake(55, 175, 1.5, 350))
            line.backgroundColor = UIColor.clearColor()
            requestReceivedImage.layer.zPosition = 10
            settledImage.layer.zPosition = 10
            pendingImage.layer.zPosition = 10
            ss4Image.layer.zPosition = 10
            ss5Image.layer.zPosition = 10
            reimburseView.addSubview(line)

            
        }else{
            ss5Image.alpha = 0
            ss5Label1.alpha = 0
            ss5Label2.alpha = 0
            
        }
        if oneJson["Status"] != nil {
            ss1First1.text = oneJson["Status"].stringValue
            ss1First1.layer.zPosition = 20
            print(oneJson["Status"].stringValue)
            
            var change1 = oneJson["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.dateFromString(change1[0])
            
            print("qwdasdad\(date)")
            ss1Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimDate"].stringValue, isDate: true)
            ss1Label2.text = change1[1]
           
        }else {
            requestReceivedImage.alpha = 0
            ss1Label1.alpha = 0
            ss1Label2.alpha = 0
            ss1First1.alpha = 0
        }

        
        rest.ConnectDetails({(json:JSON) -> () in
            dispatch_sync(dispatch_get_main_queue(),{
                if json == 401 {
                    self.redirectToHome()
                }else{
                    print(json)
                    self.connectNumberJSON = json
                    print("connectNumberJSON")
                    self.callLabel1.text = self.connectNumberJSON["result"]["CashlessClaimsNumber"].stringValue
                    self.callLabel2.text = self.connectNumberJSON["result"]["CashlessClaimsAlternateNumber"].stringValue
                }
            })
        })
        
        func addBottomBorder(color: UIColor, linewidth: CGFloat, myView:UIView) {
            let border = CALayer()
            border.backgroundColor = color.CGColor
            //border.frame = CGRectMake(5, 10, width, 10)
            border.frame = CGRectMake(-5, myView.frame.size.height + 3 - linewidth, width - 30, linewidth)
            myView.layer.addSublayer(border)
        }
        func addBottomBorderView(color: UIColor, linewidth: CGFloat, myView:UIView) {
            let border = CALayer()
            border.backgroundColor = color.CGColor
            //border.frame = CGRectMake(5, 10, width, 10)
            border.frame = CGRectMake(-3, myView.frame.size.height + 2 - linewidth, 250, 0.5)
            myView.layer.addSublayer(border)
        }
        
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: patientNameReimburseTwo)
        addBottomBorder(UIColor.lightGrayColor(), linewidth: 0.5, myView: claimNoReimburseTwo)
        addBottomBorder(UIColor.darkGrayColor(), linewidth: 0.5, myView: requestedAmountReimburseTwo)
        addBottomBorder(UIColor.darkGrayColor(), linewidth: 0.5, myView: preAuthorizationTwohide)
addBottomBorderView(UIColor.lightGrayColor(), linewidth: 0.5, myView: claimSupport)
        

        // Do any additional setup after loading the view.
        
        //dashedline
        
      
        claimSupport.layer.zPosition = 10
        self.number1.layer.cornerRadius = 10
        self.number1.layer.borderColor = UIColor.grayColor().CGColor
        self.popupView.layer.zPosition = 40
        self.number2.layer.cornerRadius = 10
        self.number2.layer.borderColor = UIColor.grayColor().CGColor
        self.number1.layer.borderWidth = 1.0
        self.number2.layer.borderWidth = 1.0
        if myClaim == 0 {
            if activeClaim == 0 {
                
                
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                claimNo2Hide.alpha = 0
            } else {
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
               claimNo2Hide.alpha = 0
            }
        }
        if myClaim == 1 {
            if activeClaim == 0 {
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                hidePopup.alpha = 0
                preAuthorizationTwohide.alpha = 0
            }else{
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                hidePopup.alpha = 0
                preAuthorizationTwohide.alpha = 0
                
            }
        }
        
    }
    
    @IBAction func showPopup(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: {
            self.view.layoutIfNeeded()
            self.popupView.alpha = 1
            self.popupView.layer.zPosition = 40
            self.reimburseView.alpha = 0.5
        })
        
    }
    
    
    
    @IBAction func closePopover(sender: UIButton) {
    
        UIView.animateWithDuration(0.3, animations: {
            self.view.layoutIfNeeded()
            
            self.popupView.alpha = 0
            self.reimburseView.alpha = 1
        })
        
    }
    var terms = false
    @IBAction func call1(sender: UIButton) {
            terms = !terms
            if terms {
                self.number1.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
                print(true)
            } else{
                 self.number1.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
                print("false")
            }
    }

    var terms1 = false
    
    @IBAction func call2(sender: UIButton) {
    
        terms1 = !terms1
        if terms1 {
           
            self.number2.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
            print("true1")
        } else{

            self.number2.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
            print("false1")
        }
        
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
class drawDottedLine2: UIView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() //Initializing the line
        CGContextSetLineWidth(context!, 5.0) //Set the points of the line
        CGContextSetStrokeColorWithColor(context!, mainBlueColor.CGColor) //set colour
        CGContextSetLineDash(context!, 0, [5.5], 1) // if equal lengths: [7.5 pts colored, 7.5 pts empty] else: [1,2] //Set Line dash
        CGContextSetLineCap(context!, CGLineCap(rawValue: 500)!) //line border radius
        CGContextMoveToPoint(context!, 0, 0) //initial point and end point on the x an y axes
        CGContextAddLineToPoint(context!, 0, 1000)
        CGContextStrokePath(context!) //To actually make the line
    }
    
}

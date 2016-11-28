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
    
    //if you have more UIViews, u
    
    
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
        reimburseView.layer.zPosition = 20
        popupView.layer.zPosition = 20
        
        navshow()
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
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
        
        var cnt1 = oneJson["ClaimsStatus"].count
        if oneJson["ClaimsStatus"][cnt1-2]["Status"] != nil{
            ss2Status2.text = oneJson["ClaimsStatus"][cnt1-2]["Status"].stringValue
            var change = oneJson["ClaimsStatus"][cnt1-2]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
            var date = dateFormatter.dateFromString(change[0])
            
            ss2Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][cnt1-2]["ClaimDate"].stringValue, isDate: true)
            ss2Label2.text = change[1]
            settledImage.image = UIImage(named: oneJson["ClaimsStatus"][cnt1-2]["Status"].stringValue)
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
            ss2Label2.alpha = 0
        }
        if oneJson["ClaimsStatus"][cnt1-3]["Status"] != nil{
            ss3Status3.text = oneJson["ClaimsStatus"][cnt1-3]["Status"].stringValue
            ss3Status3.layer.zPosition = 20
            var change1 = oneJson["ClaimsStatus"][cnt1-3]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            ss3Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][cnt1-3]["ClaimDate"].stringValue, isDate: true)
            ss3Label2.text = change1[1]
            pendingImage.image = UIImage(named: oneJson["ClaimsStatus"][cnt1-3]["Status"].stringValue)
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
        if oneJson["ClaimsStatus"][cnt1-4]["Status"] != nil{
            ss4Status.text = oneJson["ClaimsStatus"][cnt1-4]["Status"].stringValue
            ss4Status.layer.zPosition = 20
            var change1 = oneJson["ClaimsStatus"][cnt1-4]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
            var date = dateFormatter.dateFromString(change1[0])
            
            
            ss4Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][cnt1-4]["ClaimDate"].stringValue, isDate: true)
            ss4Label2.text = change1[1]
            ss4Image.image = UIImage(named: oneJson["ClaimsStatus"][cnt1-4]["Status"].stringValue)
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
        if oneJson["ClaimsStatus"][cnt1-5]["Status"] != nil{
            ss5Stat.text = oneJson["ClaimsStatus"][cnt1-5]["Status"].stringValue
            ss5Stat.layer.zPosition = 20
            var change = oneJson["ClaimsStatus"][cnt1-5]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
            var date1 = dateFormatter.dateFromString(change[0])
            print(change[0])
            print(date1)
            ss5Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][cnt1-5]["ClaimDate"].stringValue, isDate: true)
            ss5Label2.text = change[1]
            ss5Image.image = UIImage(named: oneJson["ClaimsStatus"][cnt1-5]["Status"].stringValue)
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
        if oneJson["ClaimsStatus"][cnt1-1]["Status"] != nil {
            ss1First1.text = oneJson["ClaimsStatus"][cnt1-1]["Status"].stringValue
            ss1First1.layer.zPosition = 20
            print(oneJson["Status"].stringValue)
            
            var change1 = oneJson["ClaimsStatus"][cnt1-1]["ClaimDate"].stringValue.characters.split{$0 == "T"}.map(String.init)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.dateFromString(change1[0])
            
            print("qwdasdad\(date)")
            ss1Label1.text = changeDateFormat("yyyy-MM-dd'T'HH:mm:ss", getFormat: "dd-MM-yyyy", givenDate: oneJson["ClaimsStatus"][cnt1-1]["ClaimDate"].stringValue, isDate: true)
            ss1Label2.text = change1[1]
            requestReceivedImage.image = UIImage(named:oneJson["ClaimsStatus"][cnt1-1]["Status"].stringValue)
            
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
        
        self.number1.layer.borderColor = UIColor.grayColor().CGColor
        self.popupView.layer.zPosition = 40
        
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
    func callFirst(sender: UITapGestureRecognizer) {
        print("phone")
        let phone = connectNumberJSON[sender.view!.tag]["result"]["CashlessClaimsNumber"].stringValue
        let fullPhone = phone.characters.split{$0 == "/"}.map(String.init)
        let formPhone = String(fullPhone[0]).characters.split{$0 == "-"}.map(String.init)
        let newPhone = formPhone[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + formPhone[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.callNumber(newPhone)
    }
    
    @IBAction func showPopup(sender: UIButton) {
        //UIView.animateWithDuration(0.3, animations: {
        self.view.layoutIfNeeded()
        self.popupView.alpha = 1
        self.popupView.layer.zPosition = 10
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRectMake(0, 0, 375, 800)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blurEffectView.userInteractionEnabled = false
        
        self.reimburseView.addSubview(blurEffectView) //if you have more UIViews, u
        
        savedBlurView = blurEffectView
        self.reimburseTwoScroll.scrollEnabled = false
        self.requestReceivedImage.layer.zPosition = 0
        self.settledImage.layer.zPosition = 0
        self.pendingImage.layer.zPosition = 0
        self.ss4Image.layer.zPosition = 0
        self.ss5Image.layer.zPosition = 0
        self.ss1First1.layer.zPosition = 0
        self.ss2Status2.layer.zPosition = 0
        self.ss3Status3.layer.zPosition = 0
        self.ss4Status.layer.zPosition = 0
        self.ss5Stat.layer.zPosition = 0
        // })
        
    }
    
    
    
    @IBAction func closePopover(sender: UIButton) {
        
        // UIView.animateWithDuration(0.3, animations: {
        self.view.layoutIfNeeded()
        print("hello")
        self.reimburseTwoScroll.scrollEnabled = true
        self.popupView.alpha = 0
        self.reimburseView.alpha = 1
        savedBlurView?.removeFromSuperview()
        savedBlurView?.userInteractionEnabled = false
        savedBlurView = nil
        self.requestReceivedImage.layer.zPosition = 10
        self.settledImage.layer.zPosition = 10
        self.pendingImage.layer.zPosition = 10
        self.ss4Image.layer.zPosition = 10
        self.ss5Image.layer.zPosition = 10
        self.ss1First1.layer.zPosition = 10
        self.ss2Status2.layer.zPosition = 10
        self.ss3Status3.layer.zPosition = 10
        self.ss4Status.layer.zPosition = 10
        self.ss5Stat.layer.zPosition = 10
        
        //self.reimburseView.layer.zPosition = 40
        
        // })
        
    }
    var term = false
    
    @IBAction func connectCall(sender: UIButton) {
        self.callNumber(phone)
       /* term = !term
        if number2.touchInside == true {
            let phone = connectNumberJSON["result"]["CashlessClaimsAlternateNumber"].stringValue
            print("\(phone)")
        }else{
            let phone1 = connectNumberJSON["result"]["CashlessClaimsNumber"].stringValue
            print("\(phone1)")
            
        }*/
    }
    var terms = false
    var phone = ""
    
    
    @IBAction func call1(sender: AnyObject) {
        
        self.number1.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
        self.number2.setImage(nil, forState: .Normal)
        print(true)
        phone = connectNumberJSON["result"]["CashlessClaimsNumber"].stringValue
        print("\(phone)")

    }
    
    var terms1 = false
    
    @IBAction func call2(sender: AnyObject) {
        
        self.number2.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
        self.number1.setImage(nil, forState: .Normal)
        print("true1")
        phone = connectNumberJSON["result"]["CashlessClaimsAlternateNumber"].stringValue
        print("\(phone)")

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

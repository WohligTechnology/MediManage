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
    @IBOutlet weak var claimSupport: UILabel!
    
    @IBOutlet weak var preAuthorizationTwohide: UILabel!
    @IBOutlet weak var admissionTwo: UILabel!
    @IBOutlet weak var amountTwo: UILabel!
    @IBOutlet weak var noTwo: UILabel!
    @IBOutlet weak var popupView: UIStackView!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var patientNameReimburseTwo: UILabel!
    
    @IBOutlet weak var claimNoReimburseTwo: UILabel!
    
    @IBOutlet weak var dateofAdmissionReimburseTwo: UILabel!
    
    @IBOutlet weak var requestReceivedImage: UIImageView!
    @IBOutlet weak var requestedAmountReimburseTwo: UILabel!
    
    @IBOutlet weak var claimNo2Hide: UILabel!
    
    @IBOutlet weak var callLabel1: UILabel!
    @IBOutlet weak var pendingImage: UIImageView!
    
    @IBOutlet weak var callLabel2: UILabel!
    
    @IBOutlet weak var hidePopup: UIButton!
    @IBOutlet weak var settledImage: UIImageView!
    @IBOutlet weak var reimburseTwoScroll: UIScrollView!
    
    @IBOutlet weak var number2: UIButton!
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
        print("))))))))))))))))))))))")
        print(oneJson)
                nameTwo.text = oneJson["PatientName"].stringValue
        noTwo.text = oneJson["PATNo"].stringValue
        amountTwo.text = "Rs.\(oneJson["ApprovedAmount"].stringValue)"
        //noTwo.text = "Rs.\(continueJson["PATNo"].stringValue)"
        print("\(continueJson["ApprovedAmount"].stringValue)")
        
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
        let line = drawDottedLine(frame: CGRectMake(60, 175, 1.5, 275))
        line.backgroundColor = UIColor.clearColor()
        requestReceivedImage.layer.zPosition = 10
        settledImage.layer.zPosition = 10
        pendingImage.layer.zPosition = 10
        reimburseView.addSubview(line)
        claimSupport.layer.zPosition = 10
        self.number1.layer.cornerRadius = 10
        self.number1.layer.borderColor = UIColor.grayColor().CGColor
        self.popupView.layer.zPosition = 40
        self.number2.layer.cornerRadius = 10
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
    
    
    @IBAction func closePopup(sender: UIButton)
    {
        UIView.animateWithDuration(0.3, animations: {
            self.view.layoutIfNeeded()
            
            self.popupView.alpha = 0
            self.reimburseView.alpha = 1
        })
        
    }
    var terms = false
    @IBAction func call1(sender: AnyObject) {
        
        terms = !terms
        if terms {
            //self.termsCheckbox.backgroundColor = UIColor.orangeColor()
            self.number1.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
            print(true)
        } else{
            //self.termsCheckbox.backgroundColor = nil\
            self.number1.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
            print("false")
        }
    }
    var terms1 = false
    @IBAction func call2(sender: AnyObject) {   terms1 = !terms1
        if terms {
            //self.termsCheckbox.backgroundColor = UIColor.orangeColor()
            self.number2.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
            print("true1")
        } else{
            //self.termsCheckbox.backgroundColor = nil\
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

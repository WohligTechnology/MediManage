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

    var amountReimburseTwo:String = ""
    var AdmissionTwoString = ""
    var claimsJSON: JSON!
    var closedClaimsJSON: JSON!
    var pendingClaimJSON: JSON!
    var nameReimburseTwo: String = ""
    @IBOutlet weak var nameTwo: UILabel!
    @IBOutlet weak var claimSupport: UILabel!
    
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
    
    @IBOutlet weak var pendingImage: UIImageView!
    
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
                nameTwo.text = nameReimburseTwo
                
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
        self.number1.layer.cornerRadius = 8
        self.number1.layer.borderColor = UIColor.grayColor().CGColor
        self.popupView.layer.zPosition = 40
        self.number2.layer.cornerRadius = 8
        if myClaim == 0 {
            if activeClaim == 0 {
                
                
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                
            } else {
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
               
            }
        }
        if myClaim == 1 {
            if activeClaim == 0 {
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                hidePopup.alpha = 0
            }else{
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                hidePopup.alpha = 0
                
            }
        }
        
        //json function calling for preAuthorization
        if myClaim == 0{
            if activeClaim == 0{
                rest.activeClaims({(json:JSON) -> () in
                    dispatch_sync(dispatch_get_main_queue(),{
                        if json == 401 {
                            self.redirectToHome()
                        }else{
                            print(json)
                            self.claimsJSON = json
                            self.pendingClaimJSON = self.claimsJSON["result"]["PendingClaims"]
                            dispatch_async(dispatch_get_main_queue(),{
                                if(self.pendingClaimJSON!.count == 0 ) {
                                    let noClaim = UILabel(frame: CGRectMake(90, 250, 200, 200))
                                    noClaim.text = "No History Found"
                                    noClaim.textColor = UIColor.blackColor()
                                    noClaim.textAlignment = .Center
                                    self.view.addSubview(noClaim)
                                    let viewsDictionary = ["noClaim":noClaim]
                                    let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                                    let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                                    self.view.addConstraints(noClaim_H)
                                    self.view.addConstraints(noClaim_V)
                                }
                                
                            })
                        }
                    })
                    
                })
            }else{
                rest.activeClaims({(json:JSON) -> () in
                    
                    dispatch_sync(dispatch_get_main_queue(),{
                        if json == 401 {
                            self.redirectToHome()
                        }else{
                            self.claimsJSON = json
                            self.closedClaimsJSON = self.claimsJSON["result"]["closedClaims"]
                            dispatch_async(dispatch_get_main_queue(),{
                                print("ALL IS WELL");
                                
                                
                                
                                if(self.closedClaimsJSON!.count == 0 ) {
                                    let noClaim = UILabel(frame: CGRectMake(90, 250, 200, 200))
                                    noClaim.text = "No History Found"
                                    noClaim.textColor = UIColor.blackColor()
                                    noClaim.textAlignment = .Center
                                    self.view.addSubview(noClaim)
                                    let viewsDictionary = ["noClaim":noClaim]
                                    let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                                    let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                                    self.view.addConstraints(noClaim_H)
                                    self.view.addConstraints(noClaim_V)
                                }
                                
                                
                                
                                
                                
                            })
                        }
                    })
                    
                })
            }
        }
        //json for reimbursement
        if myClaim == 1{
            if activeClaim == 0 {
                rest.reimbursementClaims({(json:JSON) -> () in
                    dispatch_sync(dispatch_get_main_queue(),{
                        if json == 401 {
                            self.redirectToHome()
                        }else{
                            print(json)
                            self.claimsJSON = json
                            self.pendingClaimJSON = self.claimsJSON["result"]["PendingClaims"]
                            dispatch_async(dispatch_get_main_queue(),{
                                
                                if(self.pendingClaimJSON!.count == 0 ) {
                                    let noClaim = UILabel(frame: CGRectMake(90, 250, 200, 200))
                                    noClaim.text = "No History Found"
                                    noClaim.textColor = UIColor.blackColor()
                                    noClaim.textAlignment = .Center
                                    self.view.addSubview(noClaim)
                                    let viewsDictionary = ["noClaim":noClaim]
                                    let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                                    let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                                    self.view.addConstraints(noClaim_H)
                                    self.view.addConstraints(noClaim_V)
                                }
                                
                            })
                        }
                    })
                    
                })
            }
                
                // Do any additional setup after loading the view.
            else {
                rest.reimbursementClaims({(json:JSON) -> () in
                    dispatch_sync(dispatch_get_main_queue(),{
                        if json == 401 {
                            self.redirectToHome()
                        }else{
                            print(json)
                            self.claimsJSON = json
                            self.closedClaimsJSON = self.claimsJSON["result"]["closedClaims"]
                            dispatch_async(dispatch_get_main_queue(),{
                                
                                
                                
                                if(self.closedClaimsJSON!.count == 0 ) {
                                    let noClaim = UILabel(frame: CGRectMake(90, 250, 200, 200))
                                    noClaim.text = "No History Found"
                                    noClaim.textColor = UIColor.blackColor()
                                    noClaim.textAlignment = .Center
                                    self.view.addSubview(noClaim)
                                    let viewsDictionary = ["noClaim":noClaim]
                                    let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                                    let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                                    self.view.addConstraints(noClaim_H)
                                    self.view.addConstraints(noClaim_V)
                                }
                                
                            })
                        }
                    })
                    
                })
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

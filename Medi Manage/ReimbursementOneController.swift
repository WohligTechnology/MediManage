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
    var mainStatusLabelDate:String! = ""
    var mainStatusLabel:String! = ""
    @IBOutlet weak var claimNo: UILabel!
    var name:String! = ""
    var id:String! = ""
    var amount:String! = ""
    @IBOutlet weak var settledDate: UILabel!
    @IBOutlet weak var fourthStatus: UILabel!
   
    @IBOutlet weak var mainStatusDate: UILabel!
        @IBOutlet weak var thirdStatus: UILabel!
    @IBOutlet weak var secondStatus: UILabel!
    @IBOutlet weak var firstStatus: UILabel!
    
    @IBOutlet weak var mainStatus: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var patientNameReimburse: UILabel!
    @IBOutlet weak var reimbursementOneScroll: UIScrollView!
    
    @IBOutlet weak var pendingStatus: UIImageView!
    @IBOutlet weak var queryStatus: UIImageView!
    
    @IBOutlet weak var knowMore: UIButton!
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
        nameLabel.text = name
        idLabel.text = id
        amountLabel.text = amount
        firstStatus.text = status1
        secondStatus.text = status2
        thirdStatus.text = status3
        fourthStatus.text = status4
        mainStatus.text = mainStatusLabel
//        var a = mainStatusLabelDate!.characters.split{$0 == "T"}.map(String.init)
      //  print(mainStatusLabelDate)
//        mainStatusDate.text = a[0]
        let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainSubHeader.subHeaderTitle.text = "REIMURSEMENT CLAIM"
        mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        self.view.addSubview(mainSubHeader)
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
            }else{
                let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
                
                mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
                mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
                self.view.addSubview(mainSubHeader)
                
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
        
        // Do any additional setup after loading the view.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "KnowMore" {
            let controller1 = segue.destinationViewController as! ReimbursementClaimTwoController
            if activeClaim == 0{
            
                controller1.nameReimbureTwo = claimsJSON["result"]["PendingClaims"][1]["PatientName"].string!
            
            }
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

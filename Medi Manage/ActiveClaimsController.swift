//
//  ActiveClaimsController.swift
//  MediManage
//
//  Created by Pranay Joshi on 10/11/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON
var gActiveClaimsController: UIViewController!
class ActiveClaimsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
let activeClaimTitle = []
    let activeClaimNo = []
    let activeClaimAmount = []
    let activeClaimsImage = ["blue_arrow_right", "blue_arrow_right"]
    var claimsJSON: JSON!
    var closedClaimsJSON: JSON!
    var pendingClaimJSON: JSON!
    var status1Date: NSDateFormatter = NSDateFormatter()
    var statusDate: String! = ""
    //var valueToPass:String!
    @IBOutlet var activeClaimController: UIView!
    @IBOutlet weak var activeClaimTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if self.pendingClaimJSON == nil{
//            let noClaim = UILabel(frame: CGRectMake(50, 60, 100, 100))
//            noClaim.text = "No History Found"
//            noClaim.textColor = UIColor.blackColor()
//            noClaim.textAlignment = .Center
//            self.activeClaimTableView.addSubview(noClaim)
//            let viewsDictionary = ["noClaim":noClaim]
//            let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
//            let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
//            view.addConstraints(noClaim_H)
//            view.addConstraints(noClaim_V)
//        }else {
//            print("nothing")
//        }
      gActiveClaimsController = self
        selectedViewController = false
        navshow()
        //header
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
                        self.activeClaimTableView.reloadData()
                        
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
                            self.activeClaimTableView.reloadData()
                            
                            
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
                        self.activeClaimTableView.reloadData()
                        
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
                            self.activeClaimTableView.reloadData()
                            
                            
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pendingClaimJSON != nil {
            return self.pendingClaimJSON.count
        }/*else{
            let noClaim = UILabel(frame: CGRectMake(50, 60, 100, 100))
            noClaim.text = "No History Found"
            noClaim.textColor = UIColor.blackColor()
            noClaim.textAlignment = .Center
            self.view.addSubview(noClaim)
            let viewsDictionary = ["noClaim":noClaim]
            let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
            view.addConstraints(noClaim_H)
            view.addConstraints(noClaim_V)

        }*/
        if self.closedClaimsJSON != nil {
            return self.closedClaimsJSON!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activeClaims") as! activeClaimsTableViewCell
        print();
        if myClaim == 0 {
        if activeClaim == 0{
        if pendingClaimJSON != 0 {
            print("FIRST ONE");
            cell.activeClaimsName.text = claimsJSON["result"]["PendingClaims"][indexPath.row]["PatientName"].string!
            cell.activeClaimId.text = claimsJSON["result"]["PendingClaims"][indexPath.row]["PATNo"].string!
            cell.activeClaimAmount.text = "Rs. \(claimsJSON["result"]["PendingClaims"][indexPath.row]["ApprovedAmount"].int!)"
            cell.activeClaimImage.image = UIImage(named: activeClaimsImage[indexPath.item])
            if (indexPath.item % 2 != 1) {
                cell.activeClaimView.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
                tableView.scrollEnabled = true
                tableView.showsVerticalScrollIndicator = false

            }
        }else if closedClaimsJSON == [] {
            print("Secong ONE");
            print("history")
            
            }

        }else {
            print("THIS IS PRINTED");
            print(closedClaimsJSON);
                if closedClaimsJSON != nil {
                    print("THIS");
                    cell.activeClaimsName.text = claimsJSON["result"]["closedClaims"][indexPath.row]["PatientName"].string!
                    cell.activeClaimId.text = claimsJSON["result"]["closedClaims"][indexPath.row]["PATNo"].string!
                    cell.activeClaimAmount.text = "Rs. \(claimsJSON["result"]["closedClaims"][indexPath.row]["ApprovedAmount"].int!)"
                    cell.activeClaimImage.image = UIImage(named: activeClaimsImage[indexPath.item])
                    //let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
                    if (indexPath.item % 2 != 1) {
                        cell.activeClaimView.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
                        tableView.scrollEnabled = true
                        tableView.showsVerticalScrollIndicator = false
                    }
                } else {
                    print("THIS IS IT");
                    let noClaim = UILabel(frame: CGRectMake(50, 60, 100, 100))
                    noClaim.text = "No History Found"
                    noClaim.textColor = UIColor.blackColor()
                    noClaim.textAlignment = .Center
                    noClaim.layer.zPosition = 100
                    self.view.addSubview(noClaim)
                    let viewsDictionary = ["noClaim":noClaim]
                    let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                  let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                   view.addConstraints(noClaim_H)
                    view.addConstraints(noClaim_V)
            }
            }
        }
        if myClaim == 1 {
        if activeClaim == 0 {
            if pendingClaimJSON != nil {
                cell.activeClaimsName.text = claimsJSON["result"]["PendingClaims"][indexPath.row]["PatientName"].string!
                cell.activeClaimId.text = claimsJSON["result"]["PendingClaims"][indexPath.row]["PATNo"].string!
                cell.activeClaimAmount.text = "Rs. \(claimsJSON["result"]["PendingClaims"][indexPath.row]["ApprovedAmount"].int!)"
                cell.activeClaimImage.image = UIImage(named: activeClaimsImage[indexPath.item])
                if (indexPath.item % 2 != 1) {
                    cell.activeClaimView.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
                    tableView.scrollEnabled = true
                    tableView.showsVerticalScrollIndicator = false
                    
                }
            }else {
                 let noClaim = UILabel(frame: CGRectMake(50, 60, 100, 100))
                noClaim.text = "No History Found"
                noClaim.textColor = UIColor.blackColor()
                noClaim.textAlignment = .Center
                noClaim.layer.zPosition = 100
                self.view.addSubview(noClaim)
                let viewsDictionary = ["noClaim":noClaim]
                let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                view.addConstraints(noClaim_H)
                view.addConstraints(noClaim_V)

            }
        }else{
            if closedClaimsJSON != nil {
                cell.activeClaimsName.text = claimsJSON["result"]["closedClaims"][indexPath.row]["PatientName"].string!
                cell.activeClaimId.text = claimsJSON["result"]["closedClaims"][indexPath.row]["PATNo"].string!
                cell.activeClaimAmount.text = "Rs. \(claimsJSON["result"]["closedClaims"][indexPath.row]["ApprovedAmount"].int!)"
                cell.activeClaimImage.image = UIImage(named: activeClaimsImage[indexPath.item])
                if (indexPath.item % 2 != 1) {
                    cell.activeClaimView.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
                    tableView.scrollEnabled = true
                    tableView.showsVerticalScrollIndicator = false
                }

            } else {
                let noClaim = UILabel(frame: CGRectMake(50, 60, 100, 100))
                noClaim.text = "No History Found"
                noClaim.textColor = UIColor.blackColor()
                noClaim.textAlignment = .Center
                noClaim.layer.zPosition = 100
                self.view.addSubview(noClaim)
                let viewsDictionary = ["noClaim":noClaim]
                let noClaim_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                let noClaim_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[noClaim]-50-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
                view.addConstraints(noClaim_H)
                view.addConstraints(noClaim_V)
            }
            }
        }
        
        return cell
        }
   // var claimsStatus:String = claimsJSON["result"]["PendingClaims"]["ClaimsStatus"]
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        preAuthOne = indexPath.row
//        performSegueWithIdentifier("activeClaims", sender: self)
        performSegueWithIdentifier("reimbursement", sender: indexPath.row)
          }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "reimbursement" {
            let controller = segue.destinationViewController as! ReimbursementOneController
            if activeClaim == 0 {
                controller.personJson = claimsJSON["result"]["PendingClaims"][preAuthOne]
            }else{
                controller.personJson = claimsJSON["result"]["closedClaims"][preAuthOne]
            }
            //let jsonResult = claimsJSON["result"]["PendingClaims"].dictionaryValue
//            if activeClaim == 0 {
//            for i in 0...preAuthOne {
//                
//                
//            controller.name = claimsJSON["result"]["PendingClaims"][i]["PatientName"].string
//                controller.id = claimsJSON["result"]["PendingClaims"][i]["PATNo"].string
//                controller.amount = "Rs. \(claimsJSON["result"]["PendingClaims"][i]["ApprovedAmount"].int!)"
//                
//               controller.status1 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][0]["Status"].string
//                    controller.status2 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][1]["Status"].string
//                     controller.status3 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][2]["Status"].string
//                    controller.status4 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][3]["Status"].string
//
//                     controller.mainStatusLabel = claimsJSON["result"]["PendingClaims"][i]["Status"].string
//                controller.mainStatusLabelDate = claimsJSON["result"]["PendingClaims"][i]["Status"]["ClaimsStatus"][0]["ClaimDate"].string
//
//            controller.personJson = claimsJSON["result"]["PendingClaims"][i]
//                
//                }
//            }else {
//                for i in 0...preAuthOne {
//                    controller.name = claimsJSON["result"]["closedClaims"][i]["PatientName"].string
//                    controller.id = claimsJSON["result"]["closedClaims"][i]["PATNo"].string
//                    controller.amount = "Rs. \(claimsJSON["result"]["closedClaims"][i]["ApprovedAmount"].int!)"
//                    controller.status1 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][0]["Status"].string
//                    controller.status2 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][1]["Status"].string
//                    controller.status3 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][2]["Status"].string
//                    controller.status4 = claimsJSON["result"]["PendingClaims"][i]["ClaimsStatus"][3]["Status"].string
//                    //controller.mainStatusLabel = claimsJSON["result"]["PendingClaims"][i]["Status"].string!
//                    status1Date.dateFormat = "yyyy-MM-dd"
//                    
//                    
//                    
//
//                }
//            }
        }
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

class activeClaimsTableViewCell: UITableViewCell {
    @IBOutlet weak var activeClaimsName: UILabel!
    @IBOutlet weak var activeClaimAmount: UILabel!
    
    @IBOutlet weak var activeClaimImage: UIImageView!
    @IBOutlet weak var activeClaimView: UIView!
    @IBOutlet weak var activeClaimId: UILabel!
}

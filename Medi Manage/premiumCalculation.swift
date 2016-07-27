//
//  premiumCalculation.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 11/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class premiumCalculation: UIView {
    
    @IBOutlet var premiumCalculationMainView: UIView!
    
    @IBOutlet weak var basicPremiumView: UIView!
    @IBOutlet weak var basicPremiumLabel: UILabel!
    @IBOutlet weak var basicPremiumCost: UILabel!
    
    @IBOutlet weak var topupPremiumView: UIView!
    @IBOutlet weak var topupPremiumLabel: UILabel!
    @IBOutlet weak var topupPremiumCost: UILabel!
    
    @IBOutlet weak var netPremiumView: UIView!
    @IBOutlet weak var netPremiumLabel: UILabel!
    @IBOutlet weak var netPremiumCost: UILabel!
    
    @IBOutlet weak var serviceTaxView: UIView!
    @IBOutlet weak var serviceTaxLabel: UILabel!
    @IBOutlet weak var serviceTaxCost: UILabel!
    
    @IBOutlet weak var totalPremiumView: UIView!
    @IBOutlet weak var totalPremiumLabel: UILabel!
    @IBOutlet weak var totalPremiumCost: UILabel!
    
    @IBOutlet weak var declaration: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var termsCheckbox: UIButton!
    
    var BasicPremium : Int64 = 0
    var TopupPremium : Int64 = 0
    var Subtotal : Int64 = 0
    var Tax : Int64 = 0
    var TotalPremium : Int64 = 0

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
        border.frame = CGRectMake(5, myView.frame.size.height, width - 45, linewidth)
        myView.layer.addSublayer(border)
    }
    
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "premiumCalculation", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        premiumCalculationMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70)
        
        declaration.font = UIFont(name: "Lato-Light", size: 10.0)
        termsLabel.font = UIFont(name: "Lato-Light", size: 10.0)
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_async(dispatch_get_main_queue(),{
                for x in 0..<json["result"]["Groups"].count{
                    self.BasicPremium = self.BasicPremium + json["result"]["Groups"][x]["Amount"].int64Value
                    self.TopupPremium = self.TopupPremium + json["result"]["Groups"][x]["TopupAmount"].int64Value
                    self.Subtotal = json["result"]["Groups"][x]["Amount"].int64Value + json["result"]["Groups"][x]["TopupAmount"].int64Value
                    self.Tax = json["result"]["Groups"][x]["Tax"].int64Value + json["result"]["Groups"][x]["TopupTax"].int64Value
                    self.TotalPremium = json["result"]["Groups"][x]["NetAmount"].int64Value + json["result"]["Groups"][x]["TopupNetAmount"].int64Value
                    
                    for y in 0..<json["result"]["Groups"][x]["Members"].count{
                        self.BasicPremium = self.BasicPremium + json["result"]["Groups"][x]["Members"][y]["Amount"].int64Value
                        self.TopupPremium = self.TopupPremium + json["result"]["Groups"][x]["Members"][y]["TopupAmount"].int64Value
                        self.Subtotal = json["result"]["Groups"][x]["Members"][y]["Amount"].int64Value + json["result"]["Groups"][x]["Members"][y]["TopupAmount"].int64Value
                        self.Tax = json["result"]["Groups"][x]["Members"][y]["Tax"].int64Value + json["result"]["Groups"][x]["Members"][y]["TopupTax"].int64Value
                        self.TotalPremium = json["result"]["Groups"][x]["Members"][y]["NetAmount"].int64Value + json["result"]["Groups"][x]["Members"][y]["TopupNetAmount"].int64Value
                    }

                }
                
                self.basicPremiumCost.text = String(self.BasicPremium)
                self.totalPremiumCost.text = String(self.TopupPremium)
                self.netPremiumCost.text = String(self.Subtotal)
                self.serviceTaxCost.text = String(self.Tax)
                self.topupPremiumCost.text = String(self.TotalPremium)
                
                })
        })
        
        //add borders
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: basicPremiumView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: topupPremiumView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: netPremiumView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: serviceTaxView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: totalPremiumView)
    }

    var terms = false
    @IBAction func termsClick(sender: AnyObject) {
        terms = !terms
        if terms {
            self.termsCheckbox.backgroundColor = UIColor.orangeColor()
        }else{
            self.termsCheckbox.backgroundColor = nil
        }
    }
    
    
    @IBAction func insuredmembersCall(sender: AnyObject) {
        if terms {
            rest.premiumConfirm({(json:JSON) -> ()in
                print(json)
                if json["state"] {
                    gPremiumCalculationController.performSegueWithIdentifier("insuredmembers", sender: nil)
                }else{
                    Popups.SharedInstance.ShowPopup("Premium Calculation", message: "Some error occured")

                }
            })
        }else{
            Popups.SharedInstance.ShowPopup("Allowed Members", message: "Please check the Terms and Conditions")

        }
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

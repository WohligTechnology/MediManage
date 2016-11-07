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
    
    
    
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 5, y: myView.frame.size.height, width: width - 45, height: linewidth)
        myView.layer.addSublayer(border)
    }
    
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "premiumCalculation", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        premiumCalculationMainView.frame = CGRect(x: 0, y: 60, width: self.frame.size.width, height: self.frame.size.height - 70)
        
        declaration.font = UIFont(name: "Lato-Light", size: 10.0)
        termsLabel.font = UIFont(name: "Lato-Light", size: 10.0)
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                print(json)
                if json == 401 {
                    LoadingOverlay.shared.hideOverlayView()
                    gPremiumCalculationController.redirectToHome()
                }else{
                for x in 0..<json["result"]["Groups"].count{
                    self.BasicPremium = self.BasicPremium + json["result"]["Groups"][x]["Amount"].int64Value
                    
                    self.TopupPremium = self.TopupPremium + json["result"]["Groups"][x]["TopupAmount"].int64Value
                    
                    self.Subtotal = self.Subtotal + json["result"]["Groups"][x]["Amount"].int64Value + json["result"]["Groups"][x]["TopupAmount"].int64Value
                    
                    self.Tax = self.Tax + json["result"]["Groups"][x]["Tax"].int64Value + json["result"]["Groups"][x]["TopupTax"].int64Value
                    
                    self.TotalPremium = self.TotalPremium + json["result"]["Groups"][x]["NetAmount"].int64Value + json["result"]["Groups"][x]["TopupNetAmount"].int64Value
                    
                    for y in 0..<json["result"]["Groups"][x]["Members"].count{
                        
                        self.BasicPremium = self.BasicPremium + json["result"]["Groups"][x]["Members"][y]["Amount"].int64Value
                        
                        self.TopupPremium = self.TopupPremium + json["result"]["Groups"][x]["Members"][y]["TopupAmount"].int64Value
                        
                        self.Subtotal = self.Subtotal + json["result"]["Groups"][x]["Members"][y]["Amount"].int64Value + json["result"]["Groups"][x]["Members"][y]["TopupAmount"].int64Value
                        
                        self.Tax = self.Tax + json["result"]["Groups"][x]["Members"][y]["Tax"].int64Value + json["result"]["Groups"][x]["Members"][y]["TopupTax"].int64Value
                        
                        self.TotalPremium = self.TotalPremium + json["result"]["Groups"][x]["Members"][y]["NetAmount"].int64Value + json["result"]["Groups"][x]["Members"][y]["TopupNetAmount"].int64Value
                        
                    }
                    
                }
                LoadingOverlay.shared.hideOverlayView()
                print(self.BasicPremium)
                    print(self.TopupPremium)
                    print(self.Subtotal)
                    print(self.Tax)
                    print(self.TotalPremium)
                    
                self.basicPremiumCost.text = String(self.BasicPremium)
                self.topupPremiumCost.text = String(self.TopupPremium)
                self.netPremiumCost.text = String(self.Subtotal)
                self.serviceTaxCost.text = String(self.Tax)
                self.totalPremiumCost.text = String(self.TotalPremium)
                }
                })
        })
        
        //add borders
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: basicPremiumView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: topupPremiumView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: netPremiumView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: serviceTaxView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: totalPremiumView)
    }

    var terms = false
    @IBAction func termsClick(_ sender: AnyObject) {
        terms = !terms
        if terms {
            //self.termsCheckbox.backgroundColor = UIColor.orangeColor()
            self.termsCheckbox.setImage(UIImage(named: "checkbox_tick"), for: UIControlState())
        } else{
            //self.termsCheckbox.backgroundColor = nil\
            self.termsCheckbox.setImage(UIImage(named: "checkbox_untick"), for: UIControlState())
        }
    }
    
    func pop() {
//        Popups.SharedInstance.ShowPopup("Premium Calculation", message: "some error")
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        gPremiumCalculationController.present(alert, animated: true, completion: nil)
//        QToasterSwift.toast(gPremiumCalculationController, text: "Welcome to QToasterSwift")
    }
    
    
    @IBAction func insuredmembersCall(_ sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gPremiumCalculationController.view)
        if terms {
            rest.premiumConfirm({(json:JSON) -> ()in
                dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {

                print(json)
                LoadingOverlay.shared.hideOverlayView()
                if json == 401 {
                    gPremiumCalculationController.redirectToHome()
                }else{
                if json["state"] {
                    print("in true")
                    gPremiumCalculationController.performSegue(withIdentifier: "insuredmembers", sender: nil)
                }else{
                    print("in else")
                    let alert = UIAlertController(title: "Premium Calculation", message: json["error_message"].stringValue, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    gPremiumCalculationController.present(alert, animated: true, completion: nil)
                }
                }
            })
            })
        } else {
            LoadingOverlay.shared.hideOverlayView()
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

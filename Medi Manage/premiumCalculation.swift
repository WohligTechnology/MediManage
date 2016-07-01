//
//  premiumCalculation.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 11/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class premiumCalculation: UIView {
    
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
        
        //add borders
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: basicPremiumView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: topupPremiumView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: netPremiumView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: serviceTaxView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: totalPremiumView)
    }

    
    
    
    @IBAction func insuredmembersCall(sender: AnyObject) {
        gPremiumCalculationController.performSegueWithIdentifier("insuredmembers", sender: nil)
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

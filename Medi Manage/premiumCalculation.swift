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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addBottomBorder(color: UIColor, width: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
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
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 70))
        self.addSubview(mainheader)
        
        premiumCalculationMainView.frame = CGRectMake(0, 90, self.frame.size.width, self.frame.size.height);
        
        //add borders
        //addBottomBorder(UIColor.blackColor(), width: 1, myView: basicPremiumView)
        //addBottomBorder(UIColor.blackColor(), width: 1, myView: topupPremiumView)
        //addBottomBorder(UIColor.blackColor(), width: 1, myView: netPremiumView)
        //addBottomBorder(UIColor.blackColor(), width: 1, myView: serviceTaxView)
        //addBottomBorder(UIColor.blackColor(), width: 1, myView: totalPremiumView)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
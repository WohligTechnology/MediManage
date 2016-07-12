//
//  benefitSummary.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 19/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class benefitSummary: UIView {
    
    @IBOutlet var benefitSummaryMainView: UIView!
    
    @IBOutlet weak var summarylbl: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "benefitSummary", bundle: bundle)
        let benefitSummary = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        benefitSummary.frame = bounds
        benefitSummary.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(benefitSummary)
        
        
        
//        
//        let scroll = UIScrollView(frame: CGRectMake(0, 0, self.frame.size.width, 1000 - 55))
//        scroll.backgroundColor = UIColor.blackColor()
//        scroll.showsVerticalScrollIndicator = false
//        benefitSummaryMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height)
//        scroll.addSubview(benefitSummaryMainView)
    }

    @IBAction func hospitalSearchCall(sender: AnyObject) {
//        gBenefitSummaryController.performSegueWithIdentifier("benefitSummaryToHospitalSearch", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
//
//  completeProfile.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 05/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class completeProfile: UIView {
    
    @IBOutlet weak var fullName: UIView!
    @IBOutlet weak var employeeNumber: UIView!
    @IBOutlet weak var dateOfBirth: UIView!
    
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var maritalStatus: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
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
        let nib = UINib(nibName: "completeProfile", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        //add borders
        addBottomBorder(UIColor.blackColor(), width: 1, myView: fullName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: employeeNumber)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: dateOfBirth)
        
        addBottomBorder(UIColor.blackColor(), width: 1, myView: mobileNumber)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: maritalStatus)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: email)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: password)
    }
    
    
}

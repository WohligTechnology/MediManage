//
//  enterOTP.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 09/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class enterOTP: UIView {
    
    @IBOutlet weak var enterOTP: UITextField!
    @IBOutlet weak var resetOTP: UIButton!
    @IBOutlet weak var submitOTP: UIButton!
    @IBOutlet weak var multiColor: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addPadding(width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRectMake(0, 0, width, myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.Always
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "enterOTP", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        addPadding(15, myView: enterOTP)
        resetOTP.layer.borderWidth = 1
        resetOTP.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).CGColor
        multiColor.font = UIFont(name: "Lato-Bold", size: 11.0)
    }
}
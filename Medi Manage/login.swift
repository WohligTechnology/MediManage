//
//  login.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 04/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class login: UIView {
    
    @IBAction func signupCall(sender: AnyObject) {
        gLoginController.performSegueWithIdentifier("signup", sender: nil)
    }
    
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    
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
        let nib = UINib(nibName: "login", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        addPadding(15, myView: mobile)
        addPadding(15, myView: password)
    }
}


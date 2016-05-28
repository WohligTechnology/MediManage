//
//  signup.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 05/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable class signup: UIView {
    
    @IBOutlet weak var employeeID: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
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
        let nib = UINib(nibName: "signup", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        addPadding(15, myView: employeeID)
        addPadding(15, myView: dateOfBirth)
        
        // CALENDER ICON
        let imageView = UIImageView()
        let image = UIImage(named: "calender_black_icon")
        imageView.image = image
        imageView.frame = CGRect(x: dateOfBirth.frame.size.width + 15, y: 15, width: 20, height: 20)
        dateOfBirth.addSubview(imageView)
    }
    
    @IBAction func loginCall(sender: AnyObject) {
        gSignupController.performSegueWithIdentifier("login", sender: nil)
    }
    @IBAction func completeProfileCall(sender: AnyObject) {
        gSignupController.performSegueWithIdentifier("completeProfile", sender: nil)
    }
}


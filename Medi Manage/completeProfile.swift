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
    
    @IBOutlet var completeProfileMainView: UIView!
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
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(0, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "completeProfile", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        //statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.addSubview(statusBar)
        
        // MARITAL STATUS ARROW ICON
        let imageView = UIImageView()
        let image = UIImage(named: "triangle_orange")
        imageView.image = image
        imageView.frame = CGRect(x: maritalStatus.frame.size.width + 30, y: 20, width: 10, height: 10)
        maritalStatus.addSubview(imageView)
        
        completeProfileMainView.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)
        
        //add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: fullName)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: employeeNumber)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: dateOfBirth)
        
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: mobileNumber)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: maritalStatus)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: email)
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: password)
    }
    
    @IBAction func retrieveLoginCall(sender: AnyObject) {
        gCompleteProfileController.performSegueWithIdentifier("retrieveLogin", sender: nil)
    }
    
}

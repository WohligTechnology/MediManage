//
//  preAuthorizationOne.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 17/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class preAuthorizationOne: UIView {
    
    @IBOutlet var preAuthorizationOneMainView: UIView!
    @IBOutlet weak var patientNameView: UIView!
    @IBOutlet weak var preAuthorizationNoView: UIView!
    @IBOutlet weak var requestedAmountView: UIView!
    
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
        border.frame = CGRectMake(-5, myView.frame.size.height + 4 - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "preAuthorizationOne", bundle: bundle)
        let inbox = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        inbox.frame = bounds
        inbox.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(inbox)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "")
        mainsubHeader.subHeaderTitle.text = "PRE - AUTHORIZATIONS"
        self.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.addSubview(mainfooter)
        
        preAuthorizationOneMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height - 175)
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: patientNameView)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: preAuthorizationNoView)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: requestedAmountView)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

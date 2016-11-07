//
//  preAuthorizationOne.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 17/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class preAuthorizationOne: UIView {
    
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
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRect(x: -5, y: myView.frame.size.height + 4 - linewidth, width: width - 30, height: linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "preAuthorizationOne", bundle: bundle)
        let inbox = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        inbox.frame = bounds
        inbox.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(inbox)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRect(x: 0, y: 20, width: width, height: 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 70, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "")
        mainsubHeader.subHeaderTitle.text = "PRE - AUTHORIZATIONS"
        self.addSubview(mainsubHeader)
        
        preAuthorizationOneMainView.frame = CGRect(x: 0, y: 120, width: self.frame.size.width, height: self.frame.size.height - 125)
        
        // add borders
        addBottomBorder(UIColor.black, linewidth: 0.5, myView: patientNameView)
        addBottomBorder(UIColor.black, linewidth: 0.5, myView: preAuthorizationNoView)
        addBottomBorder(UIColor.black, linewidth: 0.5, myView: requestedAmountView)
    }

    @IBAction func preAuthTwoCall(_ sender: AnyObject) {
        gPreAuthorizationOneController.performSegue(withIdentifier: "preAuthOneToPreAuthTwo", sender: nil)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

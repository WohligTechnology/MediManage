//
//  queryForm.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 18/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class queryForm: UIView {
    
    @IBOutlet var queryFormMainView: UIView!
    
    @IBOutlet weak var queryTextfield: UITextField!
    
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
        border.frame = CGRectMake(-5, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "queryForm", bundle: bundle)
        let queryForm = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        queryForm.frame = bounds
        queryForm.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(queryForm)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        queryFormMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 125)
        
        // add borders
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: queryTextfield)
    }
    
    @IBAction func helplineCall(sender: AnyObject) {
        gQueryFormController.performSegueWithIdentifier("queryFormToHelpline", sender: nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  insuredMembers.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 11/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class insuredMembers: UIView {
    
    @IBOutlet var insuredMembersMainView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var middleNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var sumInsuredView: UIView!
    @IBOutlet weak var topupSumInsuredView: UIView!
    @IBOutlet weak var balanceSIView: UIView!
    
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
        border.frame = CGRectMake(0, myView.frame.size.height + linewidth, width - 40, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "insuredMembers", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        insuredMembersMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height)
        
        // add borders
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: firstNameView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: middleNameView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: lastNameView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: dobView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: sumInsuredView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: topupSumInsuredView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: balanceSIView)
    }

    @IBAction func helpDeskCall(sender: AnyObject) {
        gInsuredMembersController.performSegueWithIdentifier("helpdesk", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

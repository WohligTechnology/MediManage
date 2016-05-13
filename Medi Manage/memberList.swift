//
//  memberList.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class memberList: UIView {
    
    @IBOutlet weak var dummyButton: UIButton!
    @IBOutlet var memberListMainView: UIView!
    
    @IBOutlet weak var nameViewOne: UIView!
    @IBOutlet weak var dobViewOne: UIView!
    @IBOutlet weak var domViewOne: UIView!
    
    @IBOutlet weak var nameViewTwo: UIView!
    @IBOutlet weak var domViewTwo: UIView!
    @IBOutlet weak var dobViewTwo: UIView!
    
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
        border.frame = CGRectMake(5, myView.frame.size.height, myView.frame.size.width - 10, width)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "memberList", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        scrollView.contentSize.height = 876
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.addSubview(sortnewview)
        self.addSubview(scrollView)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 70))
        self.addSubview(mainheader)
        
        memberListMainView.frame = CGRectMake(0, 90, self.frame.size.width, self.frame.size.height)
        
        dummyButton.layer.zPosition = 10000
        
        //add borders
        addBottomBorder(UIColor.blackColor(), width: 0.5, myView: nameViewOne)
        addBottomBorder(UIColor.blackColor(), width: 0.5, myView: dobViewOne)
        addBottomBorder(UIColor.blackColor(), width: 0.5, myView: domViewOne)
        addBottomBorder(UIColor.blackColor(), width: 0.5, myView: nameViewTwo)
        addBottomBorder(UIColor.blackColor(), width: 0.5, myView: dobViewTwo)
        addBottomBorder(UIColor.blackColor(), width: 0.5, myView: domViewTwo)
    }

    @IBAction func premiumcalculationCall(sender: AnyObject) {
        gMemberListController.performSegueWithIdentifier("premiumcalculation", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

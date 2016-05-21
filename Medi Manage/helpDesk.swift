//
//  helpDesk.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class helpDesk: UIView {
    
    @IBOutlet var helpDeskMainView: UIView!
    
    @IBOutlet weak var typeQuestionField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var submitQueryButton: UIButton!
    
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
        let nib = UINib(nibName: "helpDesk", bundle: bundle)
        let helpDesk = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDesk.frame = bounds
        helpDesk.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDesk)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.addSubview(mainfooter)
        
        helpDeskMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height - 55)
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 1, myView: typeQuestionField)
    }

    @IBAction func helpDeskFAQCall(sender: AnyObject) {
        gHelpDeskController.performSegueWithIdentifier("helpDeskToHelpDeskFAQ", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

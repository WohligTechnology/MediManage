//
//  helpDeskQuery.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class helpDeskQuery: UIView {
    
    @IBOutlet var helpDeskQueryMainView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "helpDeskQuery", bundle: bundle)
        let helpDeskQuery = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDeskQuery.frame = bounds
        helpDeskQuery.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDeskQuery)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.addSubview(mainfooter)
        
        helpDeskQueryMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 175)
        
    }
    @IBAction func connectCall(sender: AnyObject) {
        gHelpDeskQueryController.performSegueWithIdentifier("helpDeskQueryToConnect", sender: nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

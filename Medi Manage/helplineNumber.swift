//
//  helplineNumber.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 17/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class helplineNumber: UIView {
    
    @IBOutlet var helplineNumberMainView: UIView!
    
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
        let nib = UINib(nibName: "helplineNumber", bundle: bundle)
        let inbox = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        inbox.frame = bounds
        inbox.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(inbox)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        helplineNumberMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 125)
    }
    
    @IBAction func claimImmitationCall(sender: AnyObject) {
        gHelplineNumberController.performSegueWithIdentifier("helplineToClaimImmitation", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  myClaims.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 16/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class myClaims: UIView {
    
    @IBOutlet var myClaimsMainView: UIView!
    
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
        let nib = UINib(nibName: "myClaims", bundle: bundle)
        let myClaims = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        myClaims.frame = bounds
        myClaims.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(myClaims)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        mainsubHeader.subHeaderTitle.text = "MY CLAIMS"
        self.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.addSubview(mainfooter)
        
        myClaimsMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height - 175)
        
//        let repeated = UIView(frame: CGRectMake(0, 320, self.frame.size.width, self.frame.size.height - 175))
//        myClaimsMainView.addSubview(repeated)
//        self.addSubview(repeated)
        
    }
    @IBAction func preAuthOneCall(sender: AnyObject) {
        gMyClaimController.performSegueWithIdentifier("myClaimsToPreAuthOne", sender: nil)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

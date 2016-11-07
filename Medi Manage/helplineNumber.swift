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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "helplineNumber", bundle: bundle)
        let inbox = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        inbox.frame = bounds
        inbox.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(inbox)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRect(x: 0, y: 20, width: width, height: 50))
        self.addSubview(mainheader)
        
        helplineNumberMainView.frame = CGRect(x: 0, y: 70, width: self.frame.size.width, height: self.frame.size.height - 125)
    }
    
    @IBAction func claimImmitationCall(_ sender: AnyObject) {
        gHelplineNumberController.performSegue(withIdentifier: "helplineToClaimImmitation", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

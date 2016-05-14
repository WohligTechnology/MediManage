//
//  helpDeskFAQ.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class helpDeskFAQ: UIView {
    
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
        let nib = UINib(nibName: "helpDeskFAQ", bundle: bundle)
        let helpDeskFAQ = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDeskFAQ.frame = bounds
        helpDeskFAQ.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDeskFAQ)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

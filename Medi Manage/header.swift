//
//  header.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 11/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class header: UIView {
    
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
        let nib = UINib(nibName: "header", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

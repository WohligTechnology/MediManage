//
//  eventDetail.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/19/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class eventDetail: UIView {
    
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
        let nib = UINib(nibName: "eventDetail", bundle: bundle)
        let eventDetail = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        eventDetail.frame = bounds
        eventDetail.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(eventDetail)
    }
    
}
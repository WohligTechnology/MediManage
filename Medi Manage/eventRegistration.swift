//
//  eventRegistration.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/19/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class eventRegistration: UIView {
    
    @IBOutlet weak var dateFrom: UILabel!
    @IBOutlet weak var dateTo: UILabel!
    
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
        let nib = UINib(nibName: "eventRegistration", bundle: bundle)
        let eventRegistration = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        eventRegistration.frame = bounds
        eventRegistration.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(eventRegistration)
    }
    
}
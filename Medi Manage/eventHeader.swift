//
//  eventHeader.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/20/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class eventHeader: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var like: UIButton!
    
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
        let nib = UINib(nibName: "eventHeader", bundle: bundle)
        let eventHeader = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        eventHeader.frame = bounds
        eventHeader.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(eventHeader)
    }
    
}
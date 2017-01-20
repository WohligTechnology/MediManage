//
//  eventDescription.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/19/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class eventDescription: UIView {
    
    @IBOutlet var descriptionView: UIView!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var descriptionText: UILabel!
    
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
        let nib = UINib(nibName: "eventDescription", bundle: bundle)
        let eventDescription = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        eventDescription.frame = bounds
        eventDescription.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(eventDescription)
    }
    
}

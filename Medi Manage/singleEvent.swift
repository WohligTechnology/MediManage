//
//  singleEvent.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/18/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class singleEvent: UIView {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventDescriptionWebView: UIWebView!
    @IBOutlet weak var eventDate: UILabel!
    
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
        let nib = UINib(nibName: "singleEvent", bundle: bundle)
        let singleEvent = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        singleEvent.frame = bounds
        singleEvent.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(singleEvent)
    }
    
}

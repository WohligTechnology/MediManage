//
//  pickDate.swift
//  MediManage
//
//  Created by Jagruti Patil on 01/06/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class pickDate: UIView {
    
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
        let nib = UINib(nibName: "pickDate", bundle: bundle)
        let tutorial = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        tutorial.frame = bounds
        tutorial.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(tutorial)
    }
    
}

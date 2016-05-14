//
//  subHeader.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class subHeader: UIView {
    
    @IBOutlet weak var subHeaderTitle: UILabel!
    @IBOutlet weak var subHeaderIcon: UIImageView!
    
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
        let nib = UINib(nibName: "subHeader", bundle: bundle)
        let footer = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        footer.frame = bounds
        footer.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(footer)
        
        subHeaderTitle.text = "HELP DESK"
        
        //let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        //self.addSubview(mainsubHeader)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

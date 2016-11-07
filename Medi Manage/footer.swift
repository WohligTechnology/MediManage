//
//  footer.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 13/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class footer: UIView {
    
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
        let nib = UINib(nibName: "footer", bundle: bundle)
        let footer = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        footer.frame = bounds
        footer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(footer)
    }

    @IBAction func footerHelpDesk(_ sender: AnyObject) {
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

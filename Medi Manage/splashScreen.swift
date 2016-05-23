//
//  splashScreen.swift
//  MediManage
//
//  Created by Harsh Thakkar on 23/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class splashScreen: UIView {
    
    @IBOutlet weak var getStartedButton: UIButton!
    
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
        let nib = UINib(nibName: "splashScreen", bundle: bundle)
        let splashScreen = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        splashScreen.frame = bounds
        splashScreen.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(splashScreen)
        
        getStartedButton.layer.cornerRadius = 10
        getStartedButton.clipsToBounds = true
        getStartedButton.layer.borderWidth = 1
        getStartedButton.layer.borderColor = UIColor.whiteColor().CGColor
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

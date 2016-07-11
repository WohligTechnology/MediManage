//
//  tutorial.swift
//  MediManage
//
//  Created by Harsh Thakkar on 24/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class tutorial: UIView {
    
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
        let nib = UINib(nibName: "tutorial", bundle: bundle)
        let tutorial = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        tutorial.frame = bounds
        tutorial.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(tutorial)
    }
    
    @IBAction func signUpCall(sender: AnyObject) {
        gTutorialController.performSegueWithIdentifier("tutorialToSignUp", sender: nil)
    }

    @IBAction func signInCall(sender: AnyObject) {
        gTutorialController.performSegueWithIdentifier("tutorialToSignIn", sender: nil)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

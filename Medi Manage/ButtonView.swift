//
//  ButtonView.swift
//  MediManage
//
//  Created by Jagruti  on 21/09/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ButtonView: UIView {

    @IBOutlet weak var buttonLabel: UIButton!
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
        let nib = UINib(nibName: "ButtonView", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
    }

    @IBAction func payNow(sender: AnyObject) {
        let pdfURL = NSURL(string: "https://corporate.medimanage.com".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        UIApplication.sharedApplication().openURL(pdfURL)
    }
}

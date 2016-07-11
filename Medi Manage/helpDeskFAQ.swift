//
//  helpDeskFAQ.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class helpDeskFAQ: UIView {
    
    @IBOutlet weak var dummyButton: UIButton!
    @IBOutlet var helpDeskFAQMainView: UIView!
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
        let nib = UINib(nibName: "helpDeskFAQ", bundle: bundle)
        let helpDeskFAQ = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDeskFAQ.frame = bounds
        helpDeskFAQ.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDeskFAQ)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_four")
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.addSubview(mainsubHeader)
        
        dummyButton.layer.zPosition = 10000
        print(categoryId)
        rest.FaqDetails({(json:JSON) -> ()in
            print(json)
        })
        
//        helpDeskFAQMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height - 175)        
        
    }
    @IBAction func helpDeskQueryCall(sender: AnyObject) {
        gHelpDeskFAQController.performSegueWithIdentifier("helpDeskFAQToHelpDeskQuery", sender: nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

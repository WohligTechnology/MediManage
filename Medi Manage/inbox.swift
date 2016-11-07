//
//  inbox.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 16/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class inbox: UIView {
    
    @IBOutlet var inboxMainView: UIView!
    
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
        let nib = UINib(nibName: "inbox", bundle: bundle)
        let inbox = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        inbox.frame = bounds
        inbox.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(inbox)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRect(x: 0, y: 20, width: width, height: 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 70, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "message_icon")
        mainsubHeader.subHeaderTitle.text = "INBOX"
        self.addSubview(mainsubHeader)
        
        inboxMainView.frame = CGRect(x: 0, y: 120, width: self.frame.size.width, height: self.frame.size.height - 125)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  connect.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 14/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class connect: UIView {
    
    @IBOutlet var connectMainView: UIView!
    
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
        let nib = UINib(nibName: "connect", bundle: bundle)
        let connect = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        connect.frame = bounds
        connect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(connect)
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 60, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_four")
        mainsubHeader.subHeaderTitle.text = "CONNECT"
        self.addSubview(mainsubHeader)
        
        connectMainView.frame = CGRect(x: 0, y: 120, width: self.frame.size.width, height: self.frame.size.height - 125)
        
    }
    
    @IBAction func myClaimsCall(_ sender: AnyObject) {
        gConnectController.performSegue(withIdentifier: "connectToMainClaims", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

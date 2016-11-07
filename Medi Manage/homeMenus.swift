//
//  homeMenus.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 16/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class homeMenus: UIView {
    
    @IBOutlet var homeMenuMainView: UIView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    
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
        let nib = UINib(nibName: "homeMenus", bundle: bundle)
        let homeMenus = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        homeMenus.frame = bounds
        homeMenus.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(homeMenus)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

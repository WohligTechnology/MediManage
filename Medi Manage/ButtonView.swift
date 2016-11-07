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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ButtonView", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview);
        
    }

    @IBAction func payNow(_ sender: AnyObject) {
        let pdfURL = URL(string: "https://corporate.medimanage.com".addingPercentEscapes(using: String.Encoding.utf8)!)!
        UIApplication.shared.openURL(pdfURL)
    }
}

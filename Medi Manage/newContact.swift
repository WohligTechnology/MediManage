//
//  newContact.swift
//  MediManage
//
//  Created by Jagruti  on 08/08/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class newContact: UIView {
    
    var contactDetails : JSON = ""
    
    @IBOutlet weak var ccNoOne: UILabel!
    @IBOutlet weak var ccNoTwo: UILabel!
    @IBOutlet weak var reimbursement: UILabel!
    @IBOutlet weak var queries: UILabel!
    @IBOutlet weak var FirstCall: UIImageView!
    @IBOutlet weak var SecondCall: UIImageView!
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
        let nib = UINib(nibName: "newContact", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview)
//        LoadingOverlay.shared.showOverlay(gConnectController.view)
        rest.ConnectDetails({(json:JSON) ->() in
            DispatchQueue.main.sync(execute: {
            print(json)
            LoadingOverlay.shared.hideOverlayView()
            if json["state"].bool! {
                self.contactDetails = json["result"]
                self.ccNoOne.text = json["result"]["CashlessClaimsNumber"].stringValue
                self.ccNoTwo.text = json["result"]["CashlessClaimsAlternateNumber"].stringValue
                self.reimbursement.text = json["result"]["ReimbursementEmail"].stringValue
                self.queries.text = json["result"]["QueriesEmail"].stringValue
            }else{
                Popups.SharedInstance.ShowPopup("Connect", message: "Some ERROR occured")
            }
            })
        })
        
        let onFirstCall =  UITapGestureRecognizer(target: self, action: #selector(callFirst))
        self.FirstCall.addGestureRecognizer(onFirstCall)
        FirstCall.isUserInteractionEnabled = true
        ccNoOne.isUserInteractionEnabled = true
        
        let onSecondCall =  UITapGestureRecognizer(target: self, action: #selector(callSecond))
        self.SecondCall.addGestureRecognizer(onSecondCall)
        SecondCall.isUserInteractionEnabled = true
        ccNoTwo.isUserInteractionEnabled = true

        
    }
    func callFirst() {
        gConnectController.callNumber(self.ccNoOne.text!)
    }
    func callSecond() {
        gConnectController.callNumber(self.ccNoTwo.text!)

    }
}

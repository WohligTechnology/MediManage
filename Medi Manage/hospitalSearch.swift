//
//  hospitalSearch.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 16/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class hospitalSearch: UIView, UITextFieldDelegate {
    
    @IBOutlet var hospitalSearchMainView: UIView!
    @IBOutlet weak var yourLocation: UITextField!
    @IBOutlet weak var hospitalName: UITextField!
    @IBOutlet weak var greenIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(0, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "hospitalSearch", bundle: bundle)
        let hospitalSearch = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        hospitalSearch.frame = bounds
        hospitalSearch.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(hospitalSearch)
        
        self.yourLocation.delegate = self
        self.hospitalName.delegate = self
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_five")
        mainsubHeader.subHeaderTitle.text = "HOSPITAL SEARCH"
        self.addSubview(mainsubHeader)
        
        hospitalSearchMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height)
        
        greenIcon.layer.cornerRadius = 2
        greenIcon.clipsToBounds = true
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: yourLocation)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: hospitalName)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        yourLocation.resignFirstResponder()
        hospitalName.resignFirstResponder()
        return true;
    }

    
    @IBAction func hospitalResultCall(sender: AnyObject) {
        
        if self.yourLocation.text != "" || self.hospitalName.text != ""{
            if self.yourLocation.text == "" {
                
                hospitalNameText = self.hospitalName.text
            }else if self.hospitalName.text == "" {
                hospitalSearchText = self.yourLocation.text
            }else{
                hospitalSearchText = self.yourLocation.text!
                hospitalNameText = self.hospitalName.text!

            }
//            hospitalSearchText = self.yourLocation.text! + "%20" + self.hospitalName.text!
            
            gHospitalSearchController.performSegueWithIdentifier("hospitalSearchToHospitalResult", sender: nil)
        }else{
            Popups.SharedInstance.ShowPopup("Hospital Search", message: "Mention Hospital Location OR` Name")
        }
        
    }
}

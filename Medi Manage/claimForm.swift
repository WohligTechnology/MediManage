//
//  claimForm.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 16/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class claimForm: UIView {
    
    @IBOutlet var claimFormMainView: UIView!
    
    @IBOutlet weak var selectPatient: UITextField!
    @IBOutlet weak var hospitalName: UITextField!
    @IBOutlet weak var hospitalAddress: UITextField!
    @IBOutlet weak var dateOfAdmission: UITextField!
    @IBOutlet weak var dateOfDischarge: UITextField!
    @IBOutlet weak var diagnosis: UITextField!
    @IBOutlet weak var claimAmount: UITextField!
    
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
        let nib = UINib(nibName: "claimForm", bundle: bundle)
        let claimForm = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        claimForm.frame = bounds
        claimForm.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(claimForm)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "claim_flag")
        mainsubHeader.subHeaderTitle.text = "CLAIM FORM"
        self.addSubview(mainsubHeader)
        
        claimFormMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height)
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: selectPatient)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: hospitalName)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: hospitalAddress)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: dateOfAdmission)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: dateOfDischarge)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: diagnosis)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: claimAmount)
        
        // selectPatient ARROW ICON
        let simageView = UIImageView()
        let simage = UIImage(named: "triangle_orange")
        simageView.image = simage
        simageView.frame = CGRect(x: selectPatient.frame.size.width + 30, y: 10, width: 10, height: 10)
        selectPatient.addSubview(simageView)
        
        // dateOfAdmission CALENDER ICON
        let aimageView = UIImageView()
        let aimage = UIImage(named: "calender_black_icon")
        aimageView.image = aimage
        aimageView.frame = CGRect(x: dateOfAdmission.frame.size.width + 30, y: 10, width: 15, height: 15)
        dateOfAdmission.addSubview(aimageView)
        
        // dateOfDischarge CALENDER ICON
        let dimageView = UIImageView()
        let dimage = UIImage(named: "calender_black_icon")
        dimageView.image = dimage
        dimageView.frame = CGRect(x: dateOfDischarge.frame.size.width + 30, y: 10, width: 15, height: 15)
        dateOfDischarge.addSubview(dimageView)
        
    }

    @IBAction func documentChecklistCall(sender: AnyObject) {
        gClaimFormController.performSegueWithIdentifier("claimFormToDocumentChecklist", sender: nil)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

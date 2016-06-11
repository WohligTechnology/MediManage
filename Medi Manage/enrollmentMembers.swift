//
//  enrollmentMembers.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 10/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable class enrollmentMembers: UIView, enrollmentDelegate {
    
    @IBOutlet var enrollmentMembersMainView: UIView!
    
    @IBOutlet weak var personOneFirstName: UITextField!
    @IBOutlet weak var personOneMiddleName: UITextField!
    @IBOutlet weak var personOneLastName: UITextField!
    @IBOutlet weak var personOneDOB: UITextField!
    @IBOutlet weak var personOneDOM: UITextField!
    
    @IBOutlet weak var personTwoFirstName: UITextField!
    @IBOutlet weak var personTwoMiddleName: UITextField!
    @IBOutlet weak var personTwoLastName: UITextField!
    @IBOutlet weak var personTwoDOB: UITextField!
    
    
    var result : String  = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        
        rest.findEmployeeProfile("Enrollments/IsEnrolled",completion: {(json:JSON) -> ()in
            print(json)
        })
       print(result)
        
    }
    
    func addPadding(width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRectMake(0, 0, width, myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.Always
        
    }
    
    func addBottomBorder(color: UIColor, width: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        myView.layer.addSublayer(border)
        
        
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "enrollmentMembers", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        enrollmentMembersMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70);
        
        //add borders
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personOneFirstName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personOneMiddleName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personOneLastName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personOneDOB)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personOneDOM)
        
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personTwoFirstName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personTwoMiddleName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personTwoLastName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: personTwoDOB)
        
        
                
    }

    @IBAction func insuredmembersCall(sender: AnyObject) {
        gEnrollmentMembersController.performSegueWithIdentifier("memberlist", sender: nil)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func someFunction(result: String) {
      self.result = result
    }
    
}



//
//  enrollmentMembers.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 10/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON



@IBDesignable class enrollmentMembers: UIView{
    
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
    
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var leftArrow: UIImageView!
    
    
    @IBOutlet weak var firstMemberIcon: UIImageView!
    @IBOutlet weak var secondMemberIcon: UIImageView!
    
    @IBOutlet weak var lblFirstMember: UILabel!
    @IBOutlet weak var lblSecondMember: UILabel!
    
    
    var ArrayState : Int = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        
        let tapright = UITapGestureRecognizer(target: self, action: Selector("tappedRight"))
        rightArrow.addGestureRecognizer(tapright)
        rightArrow.userInteractionEnabled = true
        
        let tapleft = UITapGestureRecognizer(target: self, action: Selector("tappedLeft"))
        leftArrow.addGestureRecognizer(tapleft)
        leftArrow.userInteractionEnabled = true
        
    
        
       
        rest.findEmployeeProfile("Enrollments/IsEnrolled",completion: {(json:JSON) -> ()in
            print(json)
     
            if(json == true)
            {
                
            }
            else{
                
                rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
                    print(json)
                    dispatch_async(dispatch_get_main_queue(),
                {
                    if(json["MaritalStatus"]){
                      self.ArrayState = 2
                        self.rightArrow.hidden = false
                        self.leftArrow.hidden = false
                         self.DisplayEnrollmentsDetails(json)
                    }
                    else{
                         self.DisplayEnrollmentsDetails(json)
                    }
                    
                    })
                })
                
            }
            
            
            
        })
      
        
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
    

func DisplayEnrollmentsDetails(json:JSON)
    {
      
    if(String(json["isDataAvailable"]) == "true")
    {
        
   //print(json["result"]["Groups"][0]["Members"][1])
    //print(json["result"]["Groups"][0]["Members"][1]["FirstName"])
     if(ArrayState == 0)
     {
        firstMemberIcon.image = UIImage(named: "wife_icon")
        secondMemberIcon.image = UIImage(named: "son_icon")
      lblFirstMember.text = "Wife"
      lblSecondMember.text = "Son"
    personOneFirstName.text = String(json["result"]["Groups"][0]["Members"][1]["FirstName"])
    personOneMiddleName.text = String(json["result"]["Groups"][0]["Members"][1]["MiddleName"])
    personOneLastName.text = String(json["result"]["Groups"][0]["Members"][1]["LastName"])
    personOneDOB.text = String(json["result"]["Groups"][0]["Members"][1]["DateOfBirth"])
        
    personTwoFirstName.text = String(json["result"]["Groups"][0]["Members"][2]["FirstName"])
    personTwoMiddleName.text = String(json["result"]["Groups"][0]["Members"][2]["MiddleName"])
    personTwoLastName.text = String(json["result"]["Groups"][0]["Members"][2]["LastName"])
    personTwoDOB.text = String(json["result"]["Groups"][0]["Members"][2]["DateOfBirth"])
        
        }
        if(ArrayState == 1)
        {
           // firstMemberIcon.image = UIImage(named: "wife_icon")
           // secondMemberIcon.image = UIImage(named: "son_icon")
            lblFirstMember.text = "Son"
            lblSecondMember.text = "Daughter"
            
            personOneFirstName.text = String(json["result"]["Groups"][0]["Members"][2]["FirstName"])
            personOneMiddleName.text = String(json["result"]["Groups"][0]["Members"][2]["MiddleName"])
            personOneLastName.text = String(json["result"]["Groups"][0]["Members"][2]["LastName"])
            personOneDOB.text = String(json["result"]["Groups"][0]["Members"][2]["DateOfBirth"])
            
            personTwoFirstName.text = String(json["result"]["Groups"][0]["Members"][3]["FirstName"])
            personTwoMiddleName.text = String(json["result"]["Groups"][0]["Members"][3]["MiddleName"])
            personTwoLastName.text = String(json["result"]["Groups"][0]["Members"][3]["LastName"])
            personTwoDOB.text = String(json["result"]["Groups"][0]["Members"][3]["DateOfBirth"])
        }
        
        if(ArrayState == 2)
        {
            lblFirstMember.text = "Mother"
            lblSecondMember.text = "Father"
            
            personOneFirstName.text = String(json["result"]["Groups"][0]["Members"][4]["FirstName"])
            personOneMiddleName.text = String(json["result"]["Groups"][0]["Members"][4]["MiddleName"])
            personOneLastName.text = String(json["result"]["Groups"][0]["Members"][4]["LastName"])
            personOneDOB.text = String(json["result"]["Groups"][0]["Members"][4]["DateOfBirth"])
            
            personTwoFirstName.text = String(json["result"]["Groups"][0]["Members"][5]["FirstName"])
            personTwoMiddleName.text = String(json["result"]["Groups"][0]["Members"][5]["MiddleName"])
            personTwoLastName.text = String(json["result"]["Groups"][0]["Members"][5]["LastName"])
            personTwoDOB.text = String(json["result"]["Groups"][0]["Members"][5]["DateOfBirth"])
        }
        if(ArrayState == 3)
        {
            lblFirstMember.text = "Mother in law"
            lblSecondMember.text = "Father in law"
            
            personOneFirstName.text = String(json["result"]["Groups"][0]["Members"][5]["FirstName"])
            personOneMiddleName.text = String(json["result"]["Groups"][0]["Members"][5]["MiddleName"])
            personOneLastName.text = String(json["result"]["Groups"][0]["Members"][5]["LastName"])
            personOneDOB.text = String(json["result"]["Groups"][0]["Members"][5]["DateOfBirth"])
            
            personTwoFirstName.text = String(json["result"]["Groups"][0]["Members"][6]["FirstName"])
            personTwoMiddleName.text = String(json["result"]["Groups"][0]["Members"][6]["MiddleName"])
            personTwoLastName.text = String(json["result"]["Groups"][0]["Members"][6]["LastName"])
            personTwoDOB.text = String(json["result"]["Groups"][0]["Members"][6]["DateOfBirth"])
        }
        
    }
    else{
        
        }
        
        
    }
    
    
    func tappedLeft()
    {
      if(ArrayState != 0)
      {
        ArrayState -= 1
        
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            // print(json)
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.DisplayEnrollmentsDetails(json)
                    
            })})
        }
        
    }
    func tappedRight()
    {
        if(ArrayState != 3)
        {
            
        ArrayState += 1
        print(ArrayState)
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            // print(json)
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.DisplayEnrollmentsDetails(json)
                    
            })})
        
    }
    
    }
    
    
}

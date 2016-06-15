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
    
    @IBOutlet weak var dateofMarriage: UITextField!
    
    @IBOutlet weak var firstMemberIcon: UIImageView!
    @IBOutlet weak var secondMemberIcon: UIImageView!
    
    @IBOutlet weak var lblFirstMember: UILabel!
    @IBOutlet weak var lblSecondMember: UILabel!
    
    
    var ArrayState : Int = 0
    var dataMemberArray = []
    var DataMemberKeyPair = [[String: String]]()
    
    let myArray = [UITextField]()

    //  var ArrayTextField :[UITextField] = [personOneFirstName,personOneMiddleName,personOneLastName]
    
    
   var row1 = [String:String]()
    var row2 = [String:String]()
    var row3 = [String:String]()
    var row4 = [String:String]()
    var row5 = [String:String]()
     var row6 = [String:String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        personOneFirstName.viewWithTag(1)
        
        TextFieldChanges(personOneFirstName)
        TextFieldChanges( personOneMiddleName)
        TextFieldChanges( personOneLastName)
        TextFieldChanges( personOneDOB)
        TextFieldChanges( personOneDOM)
        TextFieldChanges( personTwoFirstName)
        TextFieldChanges( personTwoFirstName)
        TextFieldChanges(personTwoLastName)
        TextFieldChanges( personTwoDOB)
        
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
                   
                    dispatch_async(dispatch_get_main_queue(),
                {
                    if(json["MaritalStatus"]){
                   
                        self.ArrayState = 2
                        self.rightArrow.hidden = true
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

    
    
   func TextFieldChanges(textfield :UITextField )
   {
    textfield.addTarget(self, action: "textFieldDidChange" , forControlEvents: UIControlEvents.EditingChanged)
    
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
        
   
     if(ArrayState == 0)
     {
        firstMemberIcon.image = UIImage(named: "wife_icon")
        secondMemberIcon.image = UIImage(named: "son_icon")
        self.leftArrow.hidden = true
         self.dateofMarriage.hidden = false
        
         self.dateofMarriage.text = String(json["result"]["Groups"][0]["Members"][1]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
        
        GetMemberData(1,key2: 2, json: json)
        self.rightArrow.hidden = false
        }
        if(ArrayState == 1)
        {
            
            self.leftArrow.hidden = false
            self.dateofMarriage.hidden = true
            self.rightArrow.hidden = false
           
            GetMemberData(2,key2:3 , json: json)
            
           
        }
        
        if(ArrayState == 2)
        {
            self.rightArrow.hidden = false

             GetMemberData(5,key2:4 , json: json)
            
 }
        if(ArrayState == 3)
        {
          if(String(json["result"]["Groups"][0]["Members"][6]["RelationType"]) == "null")
            {
            GetMemberData(6,key2:6 , json: json)
            
          }
          else{
            self.rightArrow.hidden = true
            
             //GetMemberData(5,key2:6 , json: json)
            }
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
    
    func GetMemberData(key1 : Int,key2 : Int,json : JSON) {
        
        lblFirstMember.text = String(json["result"]["Groups"][0]["Members"][key1]["RelationType"])
        personOneFirstName.text = String(json["result"]["Groups"][0]["Members"][key1]["FirstName"])
        personOneMiddleName.text = String(json["result"]["Groups"][0]["Members"][key1]["MiddleName"])
        personOneLastName.text = String(json["result"]["Groups"][0]["Members"][key1]["LastName"])
        personOneDOB.text = String(json["result"]["Groups"][0]["Members"][key1]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
        
        
         lblSecondMember.text = String(json["result"]["Groups"][0]["Members"][key2]["RelationType"])
        personTwoFirstName.text = String(json["result"]["Groups"][0]["Members"][key2]["FirstName"])
        personTwoMiddleName.text = String(json["result"]["Groups"][0]["Members"][key2]["MiddleName"])
        personTwoLastName.text = String(json["result"]["Groups"][0]["Members"][key2]["LastName"])
        personTwoDOB.text = String(json["result"]["Groups"][0]["Members"][key2]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
  
        
        DataUpdater()
        
        
   }
    
    func  DataUpdater()
    {
        if(ArrayState == 0)
        {
            
            row1["RelationType"] = lblFirstMember.text
            row1["FirstName"] = personOneFirstName.text
            row1["MiddleName"] = personOneMiddleName.text
            row1["LastName"] = personOneLastName.text
            row1["DateOfBirth"] = personOneDOB.text
            row1["DateOfRelation"] = dateofMarriage.text
            
            row2["RelationType"] = lblSecondMember.text
            row2["FirstName"] = personTwoFirstName.text
            row2["MiddleName"] = personTwoMiddleName.text
            row2["LastName"] = personTwoLastName.text
            row2["DateOfBirth"] = personTwoDOB.text
            row2["DateOfRelation"] = dateofMarriage.text
         
           
      
        }
        if(ArrayState == 1)
        {
            row2["RelationType"] = lblFirstMember.text
            row2["FirstName"] = personOneFirstName.text
            row2["MiddleName"] = personOneMiddleName.text
            row2["LastName"] = personOneLastName.text
            row2["DateOfBirth"] = personOneDOB.text
            row2["DateOfRelation"] = dateofMarriage.text
            
            row2["RelationType"] = lblSecondMember.text
            row2["FirstName"] = personTwoFirstName.text
            row2["MiddleName"] = personTwoMiddleName.text
            row2["LastName"] = personTwoLastName.text
            row2["DateOfBirth"] = personTwoDOB.text
            row2["DateOfRelation"] = dateofMarriage.text
        
        }
        if(ArrayState == 2)
        {
            
            row3["RelationType"] = lblFirstMember.text
            row3["FirstName"] = personOneFirstName.text
            row3["MiddleName"] = personOneMiddleName.text
            row3["LastName"] = personOneLastName.text
            row3["DateOfBirth"] = personOneDOB.text
            row3["DateOfRelation"] = dateofMarriage.text
            
            row4["RelationType"] = lblSecondMember.text
            row4["FirstName"] = personTwoFirstName.text
            row4["MiddleName"] = personTwoMiddleName.text
            row4["LastName"] = personTwoLastName.text
            row4["DateOfBirth"] = personTwoDOB.text
            row4["DateOfRelation"] = dateofMarriage.text

        
        }
        if(ArrayState == 2)
        {
            row5["RelationType"] = lblFirstMember.text
            row5["FirstName"] = personOneFirstName.text
            row5["MiddleName"] = personOneMiddleName.text
            row5["LastName"] = personOneLastName.text
            row5["DateOfBirth"] = personOneDOB.text
            row5["DateOfRelation"] = dateofMarriage.text
            
            row6["RelationType"] = lblSecondMember.text
            row6["FirstName"] = personTwoFirstName.text
            row6["MiddleName"] = personTwoMiddleName.text
            row6["LastName"] = personTwoLastName.text
            row6["DateOfBirth"] = personTwoDOB.text
            row6["DateOfRelation"] = dateofMarriage.text
            
            
        }
        
        
    }
    
    
    
    
    
    func textFieldDidChange(textField: UITextField,Hello:String) {
       
        if(ArrayState == 0)
        {
         row1["FirstName"] = textField.text
            print(textField)
        }
        print(row1)
    }

    
    
    
    
    
    
    
    
    
}

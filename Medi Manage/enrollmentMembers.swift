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
    
    @IBOutlet weak var personOneTick: UIImageView!
    @IBOutlet weak var personTwoTick: UIImageView!
   
    
    
    var dateDob = ""
    var datePickerView:UIDatePicker = UIDatePicker()

    
    var ArrayState : Int = 0
    var dataMemberArray = []
    
    var DataMemberKeyPair = [[String: String]]()
    
    let myArray = [UITextField]()

    //  var ArrayTextField :[UITextField] = [personOneFirstName,personOneMiddleName,personOneLastName]
   
    var TEXTFIELD = ["FirstName","MiddleName","LastName","DateOfBirth","DateOfRelation","RelationType","isSelected"]
    
    var row1 = [String:String]()
    var row2 = [String:String]()
    var row3 = [String:String]()
    var row4 = [String:String]()
    var row5 = [String:String]()
    var row6 = [String:String]()
    var row7 = [String:String]()
    var row8 = [String:String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
    
    @IBAction func personOneDatePicker(sender: UITextField) {
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
 
        
    }
    
    
    @IBAction func personTwoDatePicker(sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func dateofMarriage(sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        dateDob = dateFormatter.stringFromDate(sender.date)
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
       
        
        let FieldCase :Int = sender.tag
        
       switch FieldCase
       {
        case 3:
        personOneDOB.text = dateFormatter.stringFromDate(sender.date)
         break
        
       case 4:
        dateofMarriage.text = dateFormatter.stringFromDate(sender.date)
        break
        
       case 5:
        
         personTwoDOB.text = dateFormatter.stringFromDate(sender.date)
        break
        
       default:
    
        break
        
        }
    
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        
        ApplyChangesTextField()
        tapImageGesture()
      
        rest.findEmployeeProfile("Enrollments/IsEnrolled",completion: {(json:JSON) -> ()in
          
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
                        self.SetMemberData(json)
                        self.DisplayEnrollmentsDetails()
                        
                        
                        
                    }
                    else{
                         self.SetMemberData(json)
                        self.DisplayEnrollmentsDetails()
                        
                    }})})}})}

    
    
    func SelectedFirstPerson()
    {
        
       
        switch ArrayState {
        case 0:
            if(row1["isSelected"]! == "true")
            {
               
            row1["isSelected"] = "false"
             
             for x in 0..<5 {
                row1[TEXTFIELD[x]] = ""
             }
                
             DataUpdater1(row1)
             DisableTextField(1,flag: false)
            }
            else{
                
                row1["isSelected"] = "true"
              
                DataUpdater1(row1)
                DisableTextField(1,flag: true)
            }
            break

        case 1:
            if(row2["isSelected"]! == "true")
            {
             
                row2["isSelected"] = "false"
                
                for x in 0..<5 {
                    row1[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row2)
                DisableTextField(1,flag: false)
            }
            else{
                
                row2["isSelected"] = "true"
                
                DataUpdater1(row2)
                DisableTextField(1,flag: true)
            }
            break

        case 2:
            if(row4["isSelected"]! == "true")
            {
                
                row4["isSelected"] = "false"
                
                for x in 0..<5 {
                    row4[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row4)
                DisableTextField(1,flag: false)
            }
            else{
                
                row1["isSelected"] = "true"
                
                DataUpdater1(row4)
                DisableTextField(1,flag: true)
            }
            break
        case 3:
            if(row6["isSelected"]! == "true")
            {
              
                row1["isSelected"] = "false"
                
                for x in 0..<5 {
                    row6[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row6)
                DisableTextField(1,flag: false)
            }
            else{
                self.personOneTick.hidden = true
                row6["isSelected"] = "true"
                
                DataUpdater1(row6)
                DisableTextField(1,flag: true)
            }
            break
        default: break
           
        }
        
       
        
    }
    
  
    
    func SelectedSecondPerson()  {
      
        switch ArrayState {
        case 0:
            if(row2["isSelected"]! == "true")
            {
                
                row2["isSelected"] = "false"
                
                for x in 0..<5 {
                    row2[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row2)
                DisableTextField(2,flag: false)
            }
            else{
               
                row2["isSelected"] = "true"
                
                DataUpdater1(row2)
                DisableTextField(2,flag: true)
            }

            break
        case 1:
            if(row3["isSelected"]! == "true")
            {
               
                row3["isSelected"] = "false"
                
                for x in 0..<5 {
                    row3[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row3)
                DisableTextField(2,flag: false)
            }
            else{
               
                row3["isSelected"] = "true"
                
                DataUpdater1(row3)
                DisableTextField(2,flag: true)
            }
            break
            
        case 2:
            if(row5["isSelected"]! == "true")
            {
                
                row5["isSelected"] = "false"
                
                for x in 0..<5 {
                    row5[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row5)
                DisableTextField(2,flag: false)
            }
            else{
              
                row5["isSelected"] = "true"
                
                DataUpdater1(row5)
                DisableTextField(2,flag: true)
            }

            break
            
        case 3:
            if(row7["isSelected"]! == "true")
            {
               
                row7["isSelected"] = "false"
                
                for x in 0..<5 {
                    row7[TEXTFIELD[x]] = ""
                }
                
                DataUpdater1(row7)
                DisableTextField(2,flag: false)
            }
            else{
              
                row7["isSelected"] = "true"
                
                DataUpdater1(row7)
                DisableTextField(2,flag: true)
            }
            break
            
        default: break
            
        }
        
        
        
    }
 
    
    func DisableTextField(x: Int,flag : Bool )
    {
        if x == 1 {
            personOneFirstName.userInteractionEnabled = flag
            personOneMiddleName.userInteractionEnabled = flag
            personOneLastName.userInteractionEnabled = flag
            personOneDOB.userInteractionEnabled = flag
            dateofMarriage.userInteractionEnabled = flag
            self.personOneTick.hidden = flag
        }
        else{
            personTwoFirstName.userInteractionEnabled = flag
            personTwoMiddleName.userInteractionEnabled = flag
            personTwoLastName.userInteractionEnabled = flag
            personTwoDOB.userInteractionEnabled = flag
            dateofMarriage.userInteractionEnabled = flag
             self.personTwoTick.hidden = flag
        }
    }
    
   func TextFieldChanges(textfield :UITextField )
   {
    textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)) , forControlEvents: UIControlEvents.EditingChanged)
    
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
        addBottomBorder(UIColor.blackColor(), width: 1, myView: dateofMarriage)
        
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
    

func DisplayEnrollmentsDetails()
    {
      
   // if(String(json["isDataAvailable"]) == "true")
  //  {
      
   
     if(ArrayState == 0)
     {
        firstMemberIcon.image = UIImage(named: "wife_icon")
        secondMemberIcon.image = UIImage(named: "son_icon")
        self.leftArrow.hidden = true
         self.dateofMarriage.hidden = false
        DataUpdater1(row1)
        DataUpdater2(row2)
        self.rightArrow.hidden = false
        }
        if(ArrayState == 1)
        {
         self.leftArrow.hidden = false
         self.dateofMarriage.hidden = true
         self.rightArrow.hidden = false
         DataUpdater1(row2)
         DataUpdater2(row3)
        }
        
        if(ArrayState == 2)
        {
       DataUpdater1(row4)
       DataUpdater2(row5)
        }
        if(ArrayState == 3)
        {
        self.rightArrow.hidden = false
        DataUpdater1(row6)
        DataUpdater2(row7)
         }
        
   // }
        
    }
    
    
    
    
    
    func tappedLeft()
    {
      if(ArrayState != 0)
      {
        ArrayState -= 1
      }
 
        
        
        
    }
    func tappedRight()
    {
        if(ArrayState != 3)
        {
            
        ArrayState += 1
    
        
    }
   
    }
    
    
    
    
    
    
    
    func SetMemberData(json : JSON) {
       
        for x in 0..<6
        {
            
                let currRelation  = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
            
                switch currRelation{
             
              case "Wife":
              
                
                row1["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                row1["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                row1["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                row1["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                row1["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                row1["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                 row1[TEXTFIELD[6]] = "true"
          
                    
                   
                    
                break
                    
                    case "Son":
                    row2["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                    row2["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                    row2["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                    row2["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                    row2["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                     row2["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                    row2[TEXTFIELD[6]] =  "true"
                break
                case "Daughter":
                    row3["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                    row3["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                    row3["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                    row3["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                    row3["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                     row3["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                    row3[TEXTFIELD[6]] =  "true"
                break
                case "Mother":
                    row4["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                    row4["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                    row4["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                    row4["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                    row4["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                     row4["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                    row4[TEXTFIELD[6]] =  "true"
                    break
                case "Father":
                    row5["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                    row5["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                    row5["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                    row5["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                    row5["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                     row5["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                    row5[TEXTFIELD[6]] =  "true"
                break
                case "Mother in law":
                    row6["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                    row6["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                    row6["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                    row6["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                    row6["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                     row6["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                    row6[TEXTFIELD[6]] =  "true"
                break
                    
                case "Father in law":
                    
                    row7["RelationType"] = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
                    row7["FirstName"] = String(json["result"]["Groups"][0]["Members"][x]["FirstName"])
                    row7["MiddleName"] = String(json["result"]["Groups"][0]["Members"][x]["MiddleName"])
                    row7["LastName"] = String(json["result"]["Groups"][0]["Members"][x]["LastName"])
                    row7["DateOfBirth"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                     row7["DateOfRelation"] = String(json["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                    row7[TEXTFIELD[6]] =  "true"
                    
                break
                default:
                 
                    print(currRelation)
                    
                break
   
            }
        }
      
    }
    
  
    
    func  DataUpdater1(rows1 : [String:String])
    {
 
        
        lblFirstMember.text = rows1["RelationType"]
        personOneFirstName.text = rows1["FirstName"]
        personOneMiddleName.text =  rows1["MiddleName"]
        personOneLastName.text = rows1["LastName"]
        personOneDOB.text = rows1["DateOfBirth"]
        dateofMarriage.text = rows1["DateOfRelation"]
       
        
    }
    
    func DataUpdater2(rows2 : [String:String])
    {
        
        lblSecondMember.text = rows2["RelationType"]
        personTwoFirstName.text = rows2["FirstName"]
        personTwoMiddleName.text = rows2["MiddleName"]
        personTwoLastName.text =  rows2["LastName"]
        personTwoDOB.text   = rows2["DateOfBirth"]
    }
    
    
    func textFieldDidChange(textField: UITextField) {
       dateofMarriage.text = row1["DateOfRelation"]
     var PassTag : Int =  textField.tag
      
        if(ArrayState == 0)
        {
            if(PassTag < 5)
            {
                
                row1[TEXTFIELD[PassTag]] = textField.text
                print(row1[TEXTFIELD[PassTag]])
                DataUpdaternew(PassTag,textField: textField,row:row1)
                
            }
            else
            {
                PassTag = PassTag - 5
                row2[TEXTFIELD[PassTag]] = textField.text
                 DataUpdaternew(PassTag,textField: textField,row:row2)
                
            }
           
            
        }
            if(ArrayState == 1)
            {
                if(PassTag < 5)
                {   row2[TEXTFIELD[PassTag]] = textField.text
                    DataUpdaternew(PassTag,textField: textField,row:row2)
                 }
                else
                {   PassTag = PassTag - 5
                    row3[TEXTFIELD[PassTag]] = textField.text
                     DataUpdaternew(PassTag,textField: textField,row:row3)
            }}
                if(ArrayState == 2)
                {if(PassTag < 5)
                    {row4[TEXTFIELD[PassTag]] = textField.text
                          DataUpdaternew(PassTag,textField: textField,row:row4)
                        
                    }
                    else
                    { PassTag = PassTag - 5
                        row5[TEXTFIELD[PassTag]] = textField.text
                          DataUpdaternew(PassTag,textField: textField,row:row5)
                        
                    }
                 }
      
        if(ArrayState == 3)
        {
            if(PassTag < 5)
            {
                row6[TEXTFIELD[PassTag]] = textField.text
                  DataUpdaternew(PassTag,textField: textField,row:row6)
                
            }
            else
            {
                PassTag = PassTag - 5
                row7[TEXTFIELD[PassTag]] = textField.text
                  DataUpdaternew(PassTag,textField: textField,row:row7)
                
            }
        }
        
    
        }
    
    //Changes of TextField
    func DataUpdaternew(passtag :Int,textField :UITextField,row : [String:String])
    {
       textField.text = row[TEXTFIELD[passtag]]
      dateofMarriage.text = row1["DateOfRelation"]
        print(row1)
    }
    
    
    
    //Apply TextField
    
    func ApplyChangesTextField()
    {
        TextFieldChanges(personOneFirstName)
        TextFieldChanges(personOneMiddleName)
        TextFieldChanges(personOneLastName)
        TextFieldChanges(personOneDOB)
        TextFieldChanges(dateofMarriage)
        TextFieldChanges(personTwoFirstName)
        TextFieldChanges(personTwoFirstName)
        TextFieldChanges(personTwoLastName)
        TextFieldChanges(personTwoDOB)
        TextFieldChanges(personTwoMiddleName)
    }
    
    
    func tapImageGesture(){
        
        let tapright = UITapGestureRecognizer(target: self, action: Selector("tappedRight"))
        rightArrow.addGestureRecognizer(tapright)
        rightArrow.userInteractionEnabled = true
        
        let tapleft = UITapGestureRecognizer(target: self, action: Selector("tappedLeft"))
        leftArrow.addGestureRecognizer(tapleft)
        leftArrow.userInteractionEnabled = true
        
        let selectFirstPerson =  UITapGestureRecognizer(target: self, action: Selector("SelectedFirstPerson"))
        
        personOneTick.addGestureRecognizer(selectFirstPerson)
        personOneTick.userInteractionEnabled = true
        
        
        let selectSecondPerson =  UITapGestureRecognizer(target: self, action: Selector("SelectedSecondPerson"))
        
        personTwoTick.addGestureRecognizer(selectSecondPerson)
        personTwoTick.userInteractionEnabled = true

    }
    }

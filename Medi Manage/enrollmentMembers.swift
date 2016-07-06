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
    
    @IBOutlet weak var addChildrensfirst: UIImageView!
    
    
    @IBOutlet weak var addChildrensecond: UIImageView!
    
    var hotjson : JSON  = ""
    
    
    var dateDob = ""
    var datePickerView:UIDatePicker = UIDatePicker()
    var ArrayState : Int = 0
    
    var childrenSon : Int = 0
    var childDaughter : Int = 0
    var childrenCapacity : Int = 0
    var parentCapasity : Int = 0
    var lawsCapasity : Int = 0
    var TEXTFIELD = ["FirstName","MiddleName","LastName","DateOfBirth","DateOfRelation","RelationType","isSelected","SystemIdentifier"]
    
    
    
    var row1 = [String:String]()
    var row2 = [String:String]()
    var row3 = [String:String]()
    var row4 = [String:String]()
    var row5 = [String:String]()
    var row6 = [String:String]()
    var row7 = [String:String]()
    var row8 = [String:String]()
    
    var DateTicker = 0
    var mainjson : JSON = ""
    
    var DataMemberKeyPair = [[String: String]]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
    
    
    
    
    
    
    @IBAction func personOneDatePicker(sender: UITextField) {
        
        DateTicker = 3
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self , action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }
    
    
    @IBAction func personeTwoDatePicker(sender: UITextField) {
        DateTicker = 8
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    
    @IBAction func DateofMarriage(sender: UITextField) {
        DateTicker = 4
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        EnableAllRow()
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
                            print(json)
                            self.mainjson = json
                            
                            if(json["MaritalStatus"]){
                                self.ArrayState = 2
                                self.rightArrow.hidden = true
                                self.leftArrow.hidden = false
                                self.SetMemberData(json)
                                self.DisplayEnrollmentsDetails()
                                // print(json)
                                
                            }
                            else{
                                self.SetMemberData(json)
                                self.DisplayEnrollmentsDetails()
                                //  print(json)
                            }})})
            }})}
    
    
    func EnableAllRow()
    {
        row1[TEXTFIELD[6]] =   "false"
        row2[TEXTFIELD[6]] =   "false"
        row6[TEXTFIELD[6]] =   "false"
        row3[TEXTFIELD[6]] =   "false"
        row4[TEXTFIELD[6]] =   "false"
        row5[TEXTFIELD[6]] =   "false"
        row7[TEXTFIELD[6]] =   "false"
        
        row1[TEXTFIELD[5]] =   "Wife"
        row2[TEXTFIELD[5]] =   "Son"
        row3[TEXTFIELD[5]] =   "Daughter"
        row4[TEXTFIELD[5]] =   "Mother"
        row5[TEXTFIELD[5]] =   "Father"
        row6[TEXTFIELD[5]] =   "Mother in law"
        row7[TEXTFIELD[5]] =   "Father in law"
        
    }
    
    
    
    //   ["FirstName","MiddleName","LastName","DateOfBirth","DateOfRelation","RelationType","isSelected"]
    //     0           1          2         3              4                   5             6
    
    /* Selected Person Tick Mark One  */
    
    func SelectedFirstPerson()
    {
        switch ArrayState {
        case 0:
            if(DataMemberKeyPair[0]["isSelected"]! == "true")
            {
                DataMemberKeyPair[0]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[0][TEXTFIELD[x]] = ""
                }
                DataUpdater1(DataMemberKeyPair[0])
                DisableTextField(1,flag: false)
            }
            else{
                DataMemberKeyPair[0]["isSelected"] = "true"
                DataUpdater1(DataMemberKeyPair[0])
                DisableTextField(1,flag: true)
            }
            break
            
        case 1:
            if(DataMemberKeyPair[1]["isSelected"]! == "true")
            {   DataMemberKeyPair[1]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[1][TEXTFIELD[x]] = ""
                    
                }
                DataUpdater1(DataMemberKeyPair[1])
                DisableTextField(1,flag: false)
            }
            else{
                DataMemberKeyPair[1]["isSelected"] = "true"
                DataUpdater1(DataMemberKeyPair[1])
                DisableTextField(1,flag: true)
            }
            break
            
        case 2:
            if(DataMemberKeyPair[3]["isSelected"]! == "true")
            {
                DataMemberKeyPair[3]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[3][TEXTFIELD[x]] = ""
                    
                }
                
                DataUpdater1(DataMemberKeyPair[3])
                DisableTextField(1,flag: false)
            }
            else{
                DataMemberKeyPair[3]["isSelected"] = "true"
                DataUpdater1(DataMemberKeyPair[3])
                DisableTextField(1,flag: true)
            }
            break
        case 3:
            if(DataMemberKeyPair[5]["isSelected"]! == "true")
            {   DataMemberKeyPair[5]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[5][TEXTFIELD[x]] = ""
                }
                DataUpdater1(DataMemberKeyPair[5])
                DisableTextField(1,flag: false)
            }
            else{
                DataMemberKeyPair[5]["isSelected"] = "true"
                DataUpdater1(DataMemberKeyPair[5])
                DisableTextField(1,flag: true)
            }
            break
        default: break
            
        }
        
        
        
    }
    
    
    /* Selected Person Tick Mark Two  */
    
    func SelectedSecondPerson()  {
        
        switch ArrayState {
        case 0:
            if(DataMemberKeyPair[1]["isSelected"]! == "true")
            {
                DataMemberKeyPair[1]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[1][TEXTFIELD[x]] = ""
                    
                }
                
                DataUpdater2(DataMemberKeyPair[1])
                DisableTextField(2,flag: false)
                
                
            }
            else{
                DataMemberKeyPair[1]["isSelected"] = "true"
                DataUpdater2(DataMemberKeyPair[1])
                DisableTextField(2,flag: true)
            }
            
            
            break
        case 1:
            if(DataMemberKeyPair[2]["isSelected"]! == "true")
            {
                DataMemberKeyPair[2]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[2][TEXTFIELD[x]] = ""
                    
                    
                }
                
                DataUpdater2(DataMemberKeyPair[2])
                DisableTextField(2,flag: false)
            }
            else{
                
                DataMemberKeyPair[2]["isSelected"] = "true"
                DataUpdater2(DataMemberKeyPair[2])
                DisableTextField(2,flag: true)
            }
            break
            
        case 2:
            if(DataMemberKeyPair[4]["isSelected"]! == "true")
            {   DataMemberKeyPair[4]["isSelected"] = "false"
                
                for x in 0..<5 {
                    DataMemberKeyPair[4][TEXTFIELD[x]] = ""
                    
                }
                DataUpdater2(DataMemberKeyPair[4])
                DisableTextField(2,flag: false)
            }
            else{
                DataMemberKeyPair[4]["isSelected"] = "true"
                DataUpdater2(DataMemberKeyPair[4])
                DisableTextField(2,flag: true)
            }
            
            break
            
        case 3:
            if(DataMemberKeyPair[6]["isSelected"]! == "true")
            {
                DataMemberKeyPair[6]["isSelected"] = "false"
                for x in 0..<5 {
                    DataMemberKeyPair[6][TEXTFIELD[x]] = ""
                    
                }
                
                DataUpdater2(DataMemberKeyPair[6])
                DisableTextField(2,flag: false)
            }
            else{
                DataMemberKeyPair[6]["isSelected"] = "true"
                DataUpdater2(DataMemberKeyPair[6])
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
            if flag {
                self.personOneTick.hidden = false
            }
            else{
                self.personOneTick.hidden = true
            }
            
        }
        else{
            personTwoFirstName.userInteractionEnabled = flag
            personTwoMiddleName.userInteractionEnabled = flag
            personTwoLastName.userInteractionEnabled = flag
            personTwoDOB.userInteractionEnabled = flag
            dateofMarriage.userInteractionEnabled = flag
            if flag {
                self.personTwoTick.hidden = false
                
            }
            else{
                self.personTwoTick.hidden = true
                
            }
            
        }
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
    
    // ["FirstName","MiddleName","LastName","DateOfBirth","DateOfRelation","RelationType","isSelected"]
    
    var jsonString = [NSObject]()
    @IBAction func insuredmembersCall(sender: AnyObject) {
        
        // print(DataMemberKeyPair)
        var flagState : Bool = true
        
        for x in 0..<DataMemberKeyPair.count{
            if(DataMemberKeyPair[x][TEXTFIELD[6]] == "true" && DataMemberKeyPair[x][TEXTFIELD[5]] == "Wife")
            {
                for y in 0..<5{
                    
                    if(DataMemberKeyPair[x][TEXTFIELD[y]] == "")
                    {
                        flagState = false
                    }
                    
                }
            }
            
            if(DataMemberKeyPair[x][TEXTFIELD[6]] == "true"){
                
                //  print(DataMemberKeyPair[x])
                for y in 0..<4{
                    
                    if(DataMemberKeyPair[x][TEXTFIELD[y]] == "")
                    {
                        //   print(DataMemberKeyPair[x][TEXTFIELD[y]])
                        flagState = false
                    }}
                
            }
        }
        
        
        if(flagState == false)
        {
            Popups.SharedInstance.ShowPopup("Alert", message: "Please insert all field")
        }
        else
        {
            var nums = [Int]()
            
            for x in 0..<DataMemberKeyPair.count {
                
                if(DataMemberKeyPair[x]["isSelected"] == "true")
                {
                    
                    let jsonData = try! NSJSONSerialization.dataWithJSONObject(DataMemberKeyPair[x], options: NSJSONWritingOptions.PrettyPrinted)
                    
                    for y in 0..<mainjson["result"]["Groups"][0]["Members"].count{
                        let a = (String(mainjson["result"]["Groups"][0]["Members"][y]["SystemIdentifier"]) == String(DataMemberKeyPair[x]["SystemIdentifier"]!));
                        let b = (String(mainjson["result"]["Groups"][0]["Members"][y]["RelationType"]) == String(DataMemberKeyPair[x]["RelationType"]!));                        if( a && b ) {
                            mainjson["result"]["Groups"][0]["Members"][y]["FirstName"] = JSON(DataMemberKeyPair[x]["FirstName"]!)
                            mainjson["result"]["Groups"][0]["Members"][y]["LastName"] = JSON(DataMemberKeyPair[x]["LastName"]!)
                            mainjson["result"]["Groups"][0]["Members"][y]["MiddleName"] = JSON(DataMemberKeyPair[x]["MiddleName"]!)
                            mainjson["result"]["Groups"][0]["Members"][y]["DateOfBirth"] = JSON(DataMemberKeyPair[x]["DateOfBirth"]! + "T00:00:00")
                            if (JSON(DataMemberKeyPair[x]["DateOfRelation"]!) != "null") {
                                mainjson["result"]["Groups"][0]["Members"][y]["DateOfRelation"] = JSON(DataMemberKeyPair[x]["DateOfRelation"]! + "T00:00:00")
                            }
                            
                            
                        }
                        
                    }

                    jsonString.append(NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as NSObject)

                }
            }
            
          var  membersArray = [MembersDTO]()
            
            let members = MembersDTO()
            members.FirstName = String(DataMemberKeyPair[0][TEXTFIELD[0]])
            members.MiddleName = String(DataMemberKeyPair[0][TEXTFIELD[1]])
            members.RelationType = String(DataMemberKeyPair[0][TEXTFIELD[2]])
            members.LastName = String(DataMemberKeyPair[0][TEXTFIELD[3]])
            members.SystemIdentifier = String(DataMemberKeyPair[0][TEXTFIELD[4]])
            members.DateOfRelation = String(DataMemberKeyPair[0]["DateOfRelation"])
          
            
 
            rest.AddMembers(mainjson["result"]["Groups"][0]["Members"], completion: {(json:JSON) -> ()in
                if(json["state"] == true){
                    dispatch_async(dispatch_get_main_queue()) {
                   gEnrollmentMembersController.performSegueWithIdentifier("memberlist", sender: nil)
                        }
                }
            })

        }
        
    }
    
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        
        let options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions(rawValue: 0)
        
        
        if NSJSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try NSJSONSerialization.dataWithJSONObject(value, options: options)
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return ""
        
    }
    
    
    func DisplayEnrollmentsDetails()
    {
        
        
        if(ArrayState == 0)
        {
            
            
            self.leftArrow.hidden = true
            self.dateofMarriage.hidden = false
            DataUpdater1(DataMemberKeyPair[0])
            firstMemberIcon.image = UIImage(named: "wife_icon")
            secondMemberIcon.image = UIImage(named: "son_icon")
            DataUpdater2(DataMemberKeyPair[1])
            self.rightArrow.hidden = false
        }
        if(ArrayState == 1)
        {
            self.leftArrow.hidden = false
            self.dateofMarriage.hidden = true
            self.rightArrow.hidden = false
            firstMemberIcon.image = UIImage(named: "son_icon")
            secondMemberIcon.image = UIImage(named: "daughter_icon")
            DataUpdater1(DataMemberKeyPair[1])
            DataUpdater2(DataMemberKeyPair[2])
        }
        
        if(ArrayState == 2)
        {
            firstMemberIcon.image = UIImage(named: "mother_icon")
            secondMemberIcon.image = UIImage(named: "father_icon")
            DataUpdater1(DataMemberKeyPair[3])
            DataUpdater2(DataMemberKeyPair[4])
        }
        if(ArrayState == 3)
        {
            self.rightArrow.hidden = false
            firstMemberIcon.image = UIImage(named: "wife_icon")
            secondMemberIcon.image = UIImage(named: "son_icon")
            DataUpdater1(DataMemberKeyPair[5])
            DataUpdater2(DataMemberKeyPair[6])
        }
        
        
    }
    
    
    
    func SetMemberData(json : JSON) {
        
        for x in 0..<13
        {
            
            if(json["result"]["PlanMembers"][x]["Member"] == "C")
            {
                let limit:Int? = Int(String(json["result"]["PlanMembers"][x]["Allowed"]))
                childrenCapacity = limit!
            }
            if(json["result"]["PlanMembers"][x]["Member"] == "P")
            {
                let limit:Int? = Int(String(json["result"]["PlanMembers"][x]["Allowed"]))
                parentCapasity = limit!
            }
            if(json["result"]["PlanMembers"][x]["Member"] == "I")
            {
                let limit:Int? = Int(String(json["result"]["PlanMembers"][x]["Allowed"]))
                lawsCapasity = limit!
            }
        }
        
        
        
        for x in 0..<7
        {       let currRelation  = String(json["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Wife":
                for y in 0..<6{
                    row1[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                
                row1[TEXTFIELD[6]] = "true"
                row1[TEXTFIELD[7]] = "S"
                break
                
            case "Son":
                for y in 0..<6{
                    row2[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                row2[TEXTFIELD[6]] =  "true"
                row2[TEXTFIELD[7]] = "C"
                break
            case "Daughter":
                for y in 0..<6{
                    row3[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                row3[TEXTFIELD[6]] =  "true"
                row3[TEXTFIELD[7]] = "C"
                break
            case "Mother":
                for y in 0..<6{
                    row4[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                row4[TEXTFIELD[6]] =  "true"
                row4[TEXTFIELD[7]] = "P"
                break
            case "Father":
                for y in 0..<6{
                    row5[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                row5[TEXTFIELD[6]] =  "true"
                row5[TEXTFIELD[7]] = "P"
                break
            case "Mother in law":
                for y in 0..<6{
                    row6[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                row6[TEXTFIELD[6]] =  "true"
                row6[TEXTFIELD[7]] = "I"
                break
                
            case "Father in law":
                
                for y in 0..<6{
                    row7[TEXTFIELD[y]] = String(json["result"]["Groups"][0]["Members"][x][TEXTFIELD[y]]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                }
                row7[TEXTFIELD[6]] =  "true"
                row7[TEXTFIELD[7]] = "I"
                
                break
            default:
                
                
                
                break
                
            }
        }
        DataMemberKeyPair.append(row1)
        DataMemberKeyPair.append(row2)
        DataMemberKeyPair.append(row3)
        DataMemberKeyPair.append(row4)
        DataMemberKeyPair.append(row5)
        DataMemberKeyPair.append(row6)
        DataMemberKeyPair.append(row7)
        DataMemberKeyPair.append(row8)
        
    }
    
    
    
    func  DataUpdater1(rows1 : [String:String])
    {
        
        
        lblFirstMember.text = rows1["RelationType"]
        personOneFirstName.text = rows1["FirstName"]
        personOneMiddleName.text =  rows1["MiddleName"]
        personOneLastName.text = rows1["LastName"]
        personOneDOB.text = rows1["DateOfBirth"]
        dateofMarriage.text = rows1["DateOfRelation"]
        
        
        if(rows1[TEXTFIELD[6]] == "true")
        {
            personOneTick.hidden = false
            addChildrensfirst.hidden = false
            
        }
        else{
            personOneTick.hidden = true
            addChildrensfirst.hidden = true
        }
        
        if(rows1[TEXTFIELD[5]] == "Mother" || rows1[TEXTFIELD[5]] == "Wife" || rows1[TEXTFIELD[5]] == "Mother in law")
        {
            addChildrensfirst.hidden = true
        }
        
        
    }
    
    func DataUpdater2(rows2 : [String:String])
    {
        
        lblSecondMember.text = rows2["RelationType"]
        personTwoFirstName.text = rows2["FirstName"]
        personTwoMiddleName.text = rows2["MiddleName"]
        personTwoLastName.text =  rows2["LastName"]
        personTwoDOB.text   = rows2["DateOfBirth"]
        if(rows2[TEXTFIELD[6]] == "true")
        {
            personTwoTick.hidden = false
            addChildrensecond.hidden = false
        }
        else{
            personTwoTick.hidden = true
            addChildrensecond.hidden = true
        }
        if(rows2[TEXTFIELD[5]] == "Father" || rows2[TEXTFIELD[5]] == "Father in law")
        {
            addChildrensecond.hidden = true
        }
        
        
    }
    
    
    //Changes of TextField
    func DataUpdaternew(passtag :Int,textField :UITextField,row : [String:String])
    {
        textField.text = row[TEXTFIELD[passtag]]
        
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
        firstMemberIcon.addGestureRecognizer(selectFirstPerson)
        firstMemberIcon.userInteractionEnabled = true
        let selectSecondPerson =  UITapGestureRecognizer(target: self, action: Selector("SelectedSecondPerson"))
        secondMemberIcon.addGestureRecognizer(selectSecondPerson)
        secondMemberIcon.userInteractionEnabled = true
        
        let firstAddChildreniconGesture = UITapGestureRecognizer(target: self, action: Selector("AddChildrenfirst"))
        addChildrensfirst.addGestureRecognizer(firstAddChildreniconGesture)
        addChildrensfirst.userInteractionEnabled = true
        
        let secondAddChildrenGesture = UITapGestureRecognizer(target: self, action: Selector("AddChildrensecond"))
        addChildrensecond.addGestureRecognizer(secondAddChildrenGesture)
        addChildrensecond.userInteractionEnabled = true
        
        
    }
    
    
    
    func tappedLeft()
    {
        if(ArrayState != 0)
        {   ArrayState -= 1
            DisplayEnrollmentsDetails()
        }
        
        
        
        
    }
    func tappedRight()
    {
        if(ArrayState != 3)
        {   ArrayState += 1
            DisplayEnrollmentsDetails()
            
        }
    }
    
    
    
    
    func AddChildrenfirst()
    {
        if(DataMemberKeyPair[1]["isSelected"] == "true" || DataMemberKeyPair[2]["isSelected"] == "true")
        {
            Popups.SharedInstance.ShowPopup("Alert", message: "Max Children Riched ")
        }
    }
    
    
    
    
    func AddChildrensecond()
    {
        if(DataMemberKeyPair[1]["isSelected"] == "true" || DataMemberKeyPair[2]["isSelected"] == "true")
        {
            Popups.SharedInstance.ShowPopup("Alert", message: "Max Children Riched ")
            
        }
    }
    
    
    
    
    
    
    func textFieldDidChange(textField: UITextField) {
        
        var PassTag : Int =  textField.tag
        
        
        if(ArrayState == 0)
        {
            if(PassTag < 5)
            {
                
                DataMemberKeyPair[0][TEXTFIELD[PassTag]] = textField.text
                
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[0])
                //print(DataMemberKeyPair[0])
                
            }
            else
            {
                PassTag = PassTag - 5
                DataMemberKeyPair[1][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[1])
                //    print(DataMemberKeyPair[1])
                
            }
            
            
        }
        if(ArrayState == 1)
        {
            if(PassTag < 5)
            {   DataMemberKeyPair[1][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[1])
            }
            else
            {   PassTag = PassTag - 5
                DataMemberKeyPair[2][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[2])
            }
        }
        if(ArrayState == 2)
        {
            if(PassTag < 5)
            {
                DataMemberKeyPair[3][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[3])
                
            }
            else
            { PassTag = PassTag - 5
                DataMemberKeyPair[4][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[4])
                
            }
        }
        
        if(ArrayState == 3)
        {
            if(PassTag < 5)
            {
                DataMemberKeyPair[5][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[5])
                
            }
            else
            {
                PassTag = PassTag - 5
                DataMemberKeyPair[6][TEXTFIELD[PassTag]] = textField.text
                DataUpdaternew(PassTag,textField: textField,row:DataMemberKeyPair[6])
                
            }}}
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        
        let FieldCase :Int = DateTicker
        
        
        switch FieldCase
        {
        case 3:
            
            switch ArrayState
            {
                
            case 0:
                
                DataMemberKeyPair[0][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personOneDOB.text = dateFormatter.stringFromDate(sender.date)
                
                break
            case 1 :
                DataMemberKeyPair[1][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personOneDOB.text =  DataMemberKeyPair[1][TEXTFIELD[3]]
                break
            case 2 :
                DataMemberKeyPair[3][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personOneDOB.text =  DataMemberKeyPair[3][TEXTFIELD[3]]
                break
            case 3 :
                DataMemberKeyPair[5][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personOneDOB.text = DataMemberKeyPair[5][TEXTFIELD[3]]
                break
            default :break
                
            }
            break
            
        case 4:
            if(ArrayState == 0)
            {
                DataMemberKeyPair[0][TEXTFIELD[4]] = dateFormatter.stringFromDate(sender.date)
                dateofMarriage.text = DataMemberKeyPair[0][TEXTFIELD[4]]
            }
            
            break
            
        case 8:
            switch ArrayState
            {
            case 0:
                DataMemberKeyPair[1][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personTwoDOB.text = DataMemberKeyPair[1][TEXTFIELD[3]]
                break
            case 1 :
                DataMemberKeyPair[2][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personTwoDOB.text = DataMemberKeyPair[2][TEXTFIELD[3]]
                break
            case 2 :
                DataMemberKeyPair[4][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personTwoDOB.text = DataMemberKeyPair[4][TEXTFIELD[3]]
                
                
                break
            case 3 :
                DataMemberKeyPair[6][TEXTFIELD[3]] = dateFormatter.stringFromDate(sender.date)
                personTwoDOB.text = DataMemberKeyPair[6][TEXTFIELD[3]]
                break
            default :break
                
            }
            
            break
        default:
            
            break
            
        }
        
    }
    
    func TextFieldChanges(textfield :UITextField )
    {
        textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)) , forControlEvents: UIControlEvents.EditingChanged)
        
    }
}

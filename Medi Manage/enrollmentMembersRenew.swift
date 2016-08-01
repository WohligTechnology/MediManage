//  enrollmentMembers.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 10/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class enrollmentMembersRenew: UIView{
    
    var memberjson : JSON = [["ID":0,"Gender":2,"SystemIdentifier":"S","RelationType":"Wife"],
                             ["ID":0,"Gender":1,"SystemIdentifier":"C","RelationType":"Son"],
                             ["ID":0,"Gender":2,"SystemIdentifier":"C","RelationType":"Daughter"],
                             ["ID":0,"Gender":1,"SystemIdentifier":"P","RelationType":"Father"],
                             ["ID":0,"Gender":2,"SystemIdentifier":"P","RelationType":"Mother"],
                             ["ID":0,"Gender":1,"SystemIdentifier":"I","RelationType":"Father in law"],
                             ["ID":0,"Gender":2,"SystemIdentifier":"I","RelationType":"Mother in law"],]
    
//    var memberjson : JSON = [["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":2,"SystemIdentifier":"S","RelationType":"Wife"],
//                             ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":1,"SystemIdentifier":"C","RelationType":"Son"],
//                             ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":2,"SystemIdentifier":"C","RelationType":"Daughter"],
//                             ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":1,"SystemIdentifier":"P","RelationType":"Father"],
//                             ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":2,"SystemIdentifier":"P","RelationType":"Mother"],
//                             ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":1,"SystemIdentifier":"I","RelationType":"Father in law"],
//                             ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"Gender":2,"SystemIdentifier":"I","RelationType":"Mother in law"],]
    
    var newJsonSun : JSON = ["ID":0,"LastName":"","Gender":"1","SystemIdentifier":"C","RelationType":"Son"]
    var newJsonDaughter : JSON = ["ID":0,"LastName":"","Gender":"2","SystemIdentifier":"C","RelationType":"Daughter"]
    
//    var newJsonSun : JSON = ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"LastName":"","Gender":"1","SystemIdentifier":"C","RelationType":"Son"]
//    var newJsonDaughter : JSON = ["ID":0,"FirstName":"","MiddleName":"","LastName":"","DateOfBirth":"","DateOfRelation":"","Amount":0,"NetAmount":0,"TopupAmount":0,"TopupTax":0,"TopupNetAmount":0,"UHID":"","Exist":"","AddedAt":0,"Status":0,"Tax":0,"LastName":"","Gender":"2","SystemIdentifier":"C","RelationType":"Daughter"]
    var prePlanMembers : JSON = ["C":0,"P":0,"I":0]
    var calculatedPlanMember : JSON = ["C":0,"P":0,"I":0]
    
    var leftMember : JSON = ""
    var rightMember : JSON = ""
    var apiProjectJson : JSON = [[]]
    var DateTicker = 0
    var page = 0
    var wholeJson: JSON = ""
    var freezeleft = false
    var freezeright = false
    
    
    //OUTLATES
    
    @IBOutlet var enrollmentMembersMainView: UIView!
    
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var leftTick: UIImageView!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var leftMemberName: UILabel!
    @IBOutlet weak var leftFirstName: UITextField!
    @IBOutlet weak var leftMiddelName: UITextField!
    @IBOutlet weak var leftLastName: UITextField!
    @IBOutlet weak var leftDOB: UITextField!
    @IBOutlet weak var leftDOM: UITextField!
    @IBOutlet weak var leftAddMore: UIButton!
    
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var rightTick: UIImageView!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var rightMemberName: UILabel!
    @IBOutlet weak var rightFirstName: UITextField!
    @IBOutlet weak var rightMiddelName: UITextField!
    @IBOutlet weak var rightLastName: UITextField!
    @IBOutlet weak var rightDOB: UITextField!
    @IBOutlet weak var rightDOM: UITextField!
    @IBOutlet weak var rightAddMore: UIButton!
    
    var datePickerView:UIDatePicker = UIDatePicker()
    var datetype = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "enrollmentMembersRenew", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview);
        
        //RIGHT PERSON ICON CLICK
        let selectSecondPerson =  UITapGestureRecognizer(target: self, action: #selector(enrollmentMembersRenew.selectpright))
        self.rightIcon.addGestureRecognizer(selectSecondPerson)
        rightIcon.userInteractionEnabled = true
        
        //LEFT PERSON ICON CLICK
        let selectFirstPerson =  UITapGestureRecognizer(target: self, action: #selector(enrollmentMembersRenew.selectpleft))
        self.leftIcon.addGestureRecognizer(selectFirstPerson)
        leftIcon.userInteractionEnabled = true
        
        //HIDE LEFT ARROW INITIALLY
        self.leftArrow.hidden = true
        
        
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_sync(dispatch_get_main_queue()){
                print(json["result"])
                
                self.wholeJson = json["result"]
                LoadingOverlay.shared.hideOverlayView()
                for x in 0..<self.memberjson.count{
                    for y in 0..<json["result"]["Groups"].count{
                        for z in 0..<json["result"]["Groups"][y]["Members"].count{
                            let a = String(self.memberjson[x]["SystemIdentifier"]) == String(json["result"]["Groups"][y]["Members"][z]["SystemIdentifier"])
                            let b = self.memberjson[x]["Gender"] == json["result"]["Groups"][y]["Members"][z]["Gender"]
                            
                            if a && b {
                                self.memberjson[x] = json["result"]["Groups"][y]["Members"][z]
                                self.memberjson[x]["ActiveState"] = true
                            }else{
                                if self.memberjson[x]["ActiveState"] != true {
                                    self.memberjson[x]["ActiveState"] = false
                                }
                            }
                        }
                    }
                }
                for x in 0..<self.wholeJson["PlanMembers"].count {
                    switch self.wholeJson["PlanMembers"][x]["Member"] {
                    case "C":
                        if self.wholeJson["PlanMembers"][x]["Allowed"] > self.prePlanMembers["C"] {
                            self.prePlanMembers["C"] = self.wholeJson["PlanMembers"][x]["Allowed"]
                        }
                        break
                    case "P":
                        if self.wholeJson["PlanMembers"][x]["Allowed"] > self.prePlanMembers["P"] {
                            self.prePlanMembers["P"] = self.wholeJson["PlanMembers"][x]["Allowed"]
                        }
                        break
                    case "I":
                        if self.wholeJson["PlanMembers"][x]["Allowed"] > self.prePlanMembers["I"] {
                            self.prePlanMembers["I"] = self.wholeJson["PlanMembers"][x]["Allowed"]
                        }
                        break
                    default:
                        break
                    }
                    
                }
                self.assignMembers()
            }
            
        })
        
        
        enrollmentMembersMainView.frame = CGRectMake(0, 60, self.frame.size.width, self.frame.size.height - 60);
        
        addBottomBorder(UIColor.blackColor(), width: 1, myView: leftFirstName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: leftMiddelName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: leftLastName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: leftDOB)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: leftDOM)
        
        addBottomBorder(UIColor.blackColor(), width: 1, myView: rightFirstName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: rightMiddelName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: rightLastName)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: rightDOB)
        addBottomBorder(UIColor.blackColor(), width: 1, myView: rightDOM)
    }
    
    func addBottomBorder(color: UIColor, width: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        myView.layer.addSublayer(border)
    }
    
    //FUNCTION WHICH CHECKS ENROLLMENT PERIOD
    func checkEP() {
        if !self.wholeJson["IsInEnrollmentPeriod"] {
            switch (self.memberjson[page]["Status"], self.memberjson[page]["AddedAt"]) {
            case (1,1):
                self.freezeMembers("L")
                break
            case (1,2):
                self.unfreezeMembers("L")
                break
            case (2,1):
                self.freezeMembers("L")
                break
            case (2,2):
                self.unfreezeMembers("L")
                break
            default:
                self.unfreezeMembers("L")
                break
            }
            
            switch (self.memberjson[page+1]["Status"], self.memberjson[page+1]["AddedAt"]) {
            case (1,1):
                self.freezeMembers("R")
                break
            case (1,2):
                self.unfreezeMembers("R")
                break
            case (2,1):
                self.freezeMembers("R")
                break
            case (2,2):
                self.unfreezeMembers("R")
                break
            default:
                self.unfreezeMembers("R")
                break
            }
        }
    }
    
    // FREEZE LEFT MEMBER
    func freezeMembers(position: String) {
        if position == "L" {
            self.freezeleft = true
            self.editLeftMember(false)
        }else{
            self.freezeright = true
            self.editRightMember(false)
            
        }
    }
    
    // UNFREEZE MEMBERS
    func unfreezeMembers(position: String) {
        if position == "L" {
            self.freezeleft = false
            self.editLeftMember(true)
        }else{
            self.freezeright = false
            self.editRightMember(true)
        }
    }
    
    @IBAction func rightAddMoreClick(sender: AnyObject) {
        if checkAllowedMembers() {
            updateJson()
            addMemberToJson(self.memberjson[page+1]["SystemIdentifier"].stringValue, relation: self.memberjson[page+1]["RelationType"].stringValue)
            rightActionFunction()
        }else{
            Popups.SharedInstance.ShowPopup("Allowed Members", message: msgAllowed)
        }
        
    }
    
    @IBAction func leftAddMoreClick(sender: AnyObject) {
        if checkAllowedMembers() {
            updateJson()
            addMemberToJson(self.memberjson[page]["SystemIdentifier"].stringValue, relation: self.memberjson[page]["RelationType"].stringValue)
            leftActionFunction()
        }else{
            Popups.SharedInstance.ShowPopup("Allowed Members", message: msgAllowed)
        }
        
    }
    
    func updateJson() {
        self.memberjson[page]["FirstName"].stringValue = self.leftFirstName.text!
        self.memberjson[page]["MiddleName"].stringValue = self.leftMiddelName.text!
        self.memberjson[page]["LastName"].stringValue = self.leftLastName.text!
        self.memberjson[page]["DateOfBirth"].stringValue = self.leftDOB.text!
        self.memberjson[page]["DateOfRelation"].stringValue = self.leftDOM.text!
        
        self.memberjson[page+1]["FirstName"].stringValue = self.rightFirstName.text!
        self.memberjson[page+1]["MiddleName"].stringValue = self.rightMiddelName.text!
        self.memberjson[page+1]["LastName"].stringValue = self.rightLastName.text!
        self.memberjson[page+1]["DateOfBirth"].stringValue = self.rightDOB.text!
        self.memberjson[page+1]["DateOfRelation"].stringValue = self.rightDOM.text!
        
    }
    var afterArray : JSON = []
    
    func countMember() {
        calculatedPlanMember = ["C":0,"P":0,"I":0]
        for x in 0..<self.memberjson.count {
            if self.memberjson[x]["ActiveState"] {
                switch self.memberjson[x]["SystemIdentifier"] {
                case "C":
                    self.calculatedPlanMember["C"].int64Value = self.calculatedPlanMember["C"].int64Value+1
                    break
                case "P":
                    self.calculatedPlanMember["P"].int64Value = self.calculatedPlanMember["P"].int64Value+1
                    break
                case "I":
                    self.calculatedPlanMember["I"].int64Value = self.calculatedPlanMember["I"].int64Value+1
                    break
                default:
                    break
                }
            }
            
        }
    }
    
    var msgAllowed = ""
    
    func checkAllowedMembers() -> Bool {
        countMember()
        var check = false
        if self.calculatedPlanMember["C"].int64Value >= self.prePlanMembers["C"].int64Value {
            check = false
            msgAllowed = "You can Add Maximum  \(self.prePlanMembers["C"])  Childrens."
        }else if self.calculatedPlanMember["P"].int64Value > self.prePlanMembers["P"].int64Value {
            check = false
            msgAllowed = "You can Add Maximum  \(self.prePlanMembers["P"])  Parents."
        }else if self.calculatedPlanMember["I"].int64Value > self.prePlanMembers["I"].int64Value {
            check = false
            msgAllowed = "You can Add Maximum  \(self.prePlanMembers["I"])  Parents In Law."
        }else{
            check = true
        }
        return check
    }
    
    func addMemberToJson(identifier : String, relation : String) {
        var checkrelation = false
        afterArray = []
        for x in 0..<self.memberjson.count {
            if (self.memberjson[x]["SystemIdentifier"].stringValue == identifier && self.memberjson[x]["RelationType"].stringValue == relation) {
                
                if !checkrelation {
                    checkrelation = true
                    afterArray.arrayObject?.append(self.memberjson[x].object)
                    if relation == "Daughter" {
                        afterArray.arrayObject?.append(newJsonDaughter.object)
                    }else{
                        afterArray.arrayObject?.append(newJsonSun.object)
                    }
                }else{
                    afterArray.arrayObject?.append(self.memberjson[x].object)
                }
            }else{
                afterArray.arrayObject?.append(self.memberjson[x].object)
            }
        }
        self.memberjson = afterArray
        assignMembers()
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let dateToSave = dateFormatter.stringFromDate(sender.date)
        switch datetype {
        case 1:
            leftDOB.text = dateToSave + "T00:00:00"
            break
        case 2:
            leftDOM.text = dateToSave + "T00:00:00"
            break
        case 3:
            rightDOB.text = dateToSave + "T00:00:00"
            break
        case 4:
            rightDOM.text = dateToSave + "T00:00:00"
            break
        default:
            break
        }
        
    }
    
    @IBAction func leftDOBClick(sender: AnyObject) {
        datetype = 1
        datePickerView.datePickerMode = UIDatePickerMode.Date
        leftDOB.inputView = datePickerView
        datePickerView.addTarget(self , action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func leftDOMClick(sender: AnyObject) {
        datetype = 2
        //        print("left click")
        datePickerView.datePickerMode = UIDatePickerMode.Date
        leftDOM.inputView = datePickerView
        datePickerView.addTarget(self , action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func rightDOBClick(sender: AnyObject) {
        datetype = 3
        datePickerView.datePickerMode = UIDatePickerMode.Date
        rightDOB.inputView = datePickerView
        datePickerView.addTarget(self , action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func rightDOMClick(sender: AnyObject) {
        datetype = 4
        datePickerView.datePickerMode = UIDatePickerMode.Date
        rightDOM.inputView = datePickerView
        datePickerView.addTarget(self , action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func rightActionFunction() {
        updateJson()
        self.leftArrow.hidden = false
        page = page + 2
        if (page + 1 == self.memberjson.count || page + 2 == self.memberjson.count) {
            self.rightArrow.hidden = true
            assignMembers()
        }else{
            assignMembers()
            self.rightArrow.hidden = false
        }
        if page + 1 == self.memberjson.count {
            self.enrollmentMembersMainView.viewWithTag(22)?.hidden = true
            for x in 11...17 {
                let txtfield = self.enrollmentMembersMainView.viewWithTag(x) as? UITextField
                txtfield?.hidden = true
            }
        }
        
    }
    
    @IBAction func rightActionArrow(sender: AnyObject) {
        rightActionFunction()
    }
    
    func leftActionFunction() {
        updateJson()
        self.enrollmentMembersMainView.viewWithTag(22)?.hidden = false
        for x in 11...17 {
            let txtfield = self.enrollmentMembersMainView.viewWithTag(x) as? UITextField
            txtfield?.hidden = false
        }
        self.rightArrow.hidden = false
        page = page - 2
        if page == 0 {
            self.leftArrow.hidden = true
            assignMembers()
        }else{
            self.leftArrow.hidden = false
            assignMembers()
        }
        
    }
    
    @IBAction func leftActionArrow(sender: AnyObject) {
        leftActionFunction()
    }
    
    
    func selectpright() {
        if !freezeright {
            
            if self.rightTick.hidden {
                self.rightTick.hidden = false
                memberjson[page+1]["ActiveState"] = true
                editRightMember(true)
                
            }else{
                self.rightTick.hidden = true
                memberjson[page+1]["ActiveState"] = false
                editRightMember(false)
                
            }
        }
        
    }
    func selectpleft() {
        if !freezeleft {
            
            if self.leftTick.hidden {
                self.leftTick.hidden = false
                memberjson[page]["ActiveState"] = true
                editLeftMember(true)
            }else{
                self.leftTick.hidden = true
                memberjson[page]["ActiveState"] = false
                editLeftMember(false)
            }
        }
    }
    
    func assignMembers() {
        assignText()
    }
    
    func editLeftMember(state : Bool) {
        (self.enrollmentMembersMainView.viewWithTag(6) as? UIButton)?.enabled = state
        for x in 1...5 {
            let txtfield = self.enrollmentMembersMainView.viewWithTag(x) as? UITextField
            txtfield?.enabled = state
        }
    }
    
    func editRightMember(state : Bool) {
        (self.enrollmentMembersMainView.viewWithTag(16) as? UIButton)?.enabled = state
        for x in 11...15 {
            let txtfield = self.enrollmentMembersMainView.viewWithTag(x) as? UITextField
            txtfield?.enabled = state
        }
    }
    
    func assignText() {
        switch (self.memberjson[page]["RelationType"].stringValue) {
        case "Wife":
            self.leftIcon.image = UIImage(named: "wife_icon")
            self.leftDOM.hidden = false
            self.leftAddMore.hidden = true
            break
        case "Sun":
            self.leftIcon.image = UIImage(named: "son_icon")
            self.leftDOM.hidden = true
            self.leftAddMore.hidden = false
            break
        case "Daughter":
            self.leftIcon.image = UIImage(named: "daughter_icon")
            self.leftDOM.hidden = true
            self.leftAddMore.hidden = false
            break
        case "Mother","Mother in law":
            self.leftIcon.image = UIImage(named: "mother_icon")
            self.leftDOM.hidden = false
            self.leftAddMore.hidden = true
            break
        case "Father","Father in law":
            self.leftIcon.image = UIImage(named: "father_icon")
            self.leftDOM.hidden = false
            self.leftAddMore.hidden = true
            break
        default: break
            
        }
        
        if self.memberjson[page]["ActiveState"] {
            self.leftTick.hidden = false
            checkEP()
        }else{
            self.leftTick.hidden = true
            checkEP()
        }
        self.leftMemberName.text = self.memberjson[page]["RelationType"].stringValue
        self.leftFirstName.text = self.memberjson[page]["FirstName"].stringValue
        self.leftMiddelName.text = self.memberjson[page]["MiddleName"].stringValue
        self.leftLastName.text = self.memberjson[page]["LastName"].stringValue
        self.leftDOB.text = self.memberjson[page]["DateOfBirth"].stringValue
        self.leftDOM.text = self.memberjson[page]["DateOfRelation"].stringValue
        
        switch (self.memberjson[page+1]["RelationType"].stringValue) {
        case "Wife":
            self.rightIcon.image = UIImage(named: "wife_icon")
            self.rightDOM.hidden = false
            self.rightAddMore.hidden = true
            break
        case "Sun":
            self.rightIcon.image = UIImage(named: "son_icon")
            self.rightDOM.hidden = true
            self.rightAddMore.hidden = false
            break
        case "Daughter":
            self.rightIcon.image = UIImage(named: "daughter_icon")
            self.rightDOM.hidden = true
            self.rightAddMore.hidden = false
            break
        case "Mother","Mother in law":
            self.rightIcon.image = UIImage(named: "mother_icon")
            self.rightDOM.hidden = false
            self.rightAddMore.hidden = true
            break
        case "Father","Father in law":
            self.rightIcon.image = UIImage(named: "father_icon")
            self.rightDOM.hidden = false
            self.rightAddMore.hidden = true
            break
        default: break
            
        }
        if self.memberjson[page+1]["ActiveState"] {
            self.rightTick.hidden = false
            checkEP()
        }else{
            self.rightTick.hidden = true
            checkEP()
        }
        self.rightMemberName.text = self.memberjson[page+1]["RelationType"].stringValue
        self.rightFirstName.text = self.memberjson[page+1]["FirstName"].stringValue
        self.rightMiddelName.text = self.memberjson[page+1]["MiddleName"].stringValue
        self.rightLastName.text = self.memberjson[page+1]["LastName"].stringValue
        self.rightDOB.text = self.memberjson[page+1]["DateOfBirth"].stringValue
        self.rightDOM.text = self.memberjson[page+1]["DateOfRelation"].stringValue
        
    }
    
    //FINAL PROCESS SUBMIT MEMBERS
    @IBAction func submitMembers(sender: AnyObject) {
        updateJson()
        var msg = ""
        var finaljson :JSON = []
        var status = true
        if checkAllowedMembers(){
            for x in 0..<memberjson.count {
                if self.wholeJson["IsInEnrollmentPeriod"] {
                    if memberjson[x]["ActiveState"] {
                        for (key, itm) in memberjson[x] {
                            if key == "FirstName" || key == "MiddleName" || key == "LastName" || key == "DateOfRelation" || key == "DateOfBirth" {
                                if itm == "" && status {
                                    if memberjson[x]["SystemIdentifier"] != "C" || key != "DateOfRelation"{
                                        status = false
                                        msg = "Please Enter " + key + " of " + memberjson[x]["RelationType"].stringValue
                                    }
                                    
                                }
                            }
                            
                        }
                        finaljson.arrayObject?.append(memberjson[x].object)
                    }
                }else{
                    if (memberjson[x]["Status"] == 1 && memberjson[x]["AddedAt"] == 2) || (memberjson[x]["Status"] == 2 && memberjson[x]["AddedAt"] == 2){
                        if memberjson[x]["ActiveState"] {
                            for (key, itm) in memberjson[x] {
                                if key == "FirstName" || key == "MiddleName" || key == "LastName" || key == "DateOfRelation" || key == "DateOfBirth" {
                                    if itm == "" && status {
                                        if memberjson[x]["SystemIdentifier"] != "C" || key != "DateOfRelation"{
                                            status = false
                                            msg = "Please Enter " + key + " of " + memberjson[x]["RelationType"].stringValue
                                        }
                                    }
                                }
                            }
                            finaljson.arrayObject?.append(memberjson[x].object)
                        }
                    }
                }
            }
            if !status {
                Popups.SharedInstance.ShowPopup("Validation", message: msg)
            }else{
                print(finaljson)
                rest.AddMembers(finaljson, completion: {(json:JSON) -> ()in
                    dispatch_sync(dispatch_get_main_queue()){
                        if json["state"] {
                            gEnrollmentMembersController.performSegueWithIdentifier("memberlist", sender: nil)
                        }else{
                            if json["error_message"] != "" {
                                Popups.SharedInstance.ShowPopup("Select Members", message: json["error_message"].stringValue)
                            }else{
                                Popups.SharedInstance.ShowPopup("Select Members", message: "Some Error Occured.")

                            }
                        }
                    }
                })
            }
        }else{
            Popups.SharedInstance.ShowPopup("Allowed Members", message: msgAllowed)
        }
        
    }
    
    
}

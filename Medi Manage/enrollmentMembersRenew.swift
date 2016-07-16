//
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
                             ["ID":0,"Gender":1,"SystemIdentifier":"C","RelationType":"Sun"],
                             ["ID":0,"Gender":2,"SystemIdentifier":"C","RelationType":"Daughter"],
                             ["ID":0,"Gender":1,"SystemIdentifier":"P","RelationType":"Father"],
                             ["ID":0,"Gender":2,"SystemIdentifier":"P","RelationType":"Mother"],
                             ["ID":0,"Gender":1,"SystemIdentifier":"I","RelationType":"Father in law"],
                             ["ID":0,"Gender":2,"SystemIdentifier":"I","RelationType":"Mother in law"],]
    
    var newjson : JSON = [["LastName":"","Gender":"1","SystemIdentifier":"E"],["LastName":"","Gender":"1","SystemIdentifier":"E"]]
    var leftMember : JSON = ""
    var rightMember : JSON = ""
    var apiProjectJson : JSON = [[]]
    var DateTicker = 0
    var page = 0
    
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
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        self.leftArrow.hidden = true
        
        let selectSecondPerson =  UITapGestureRecognizer(target: self, action: #selector(enrollmentMembersRenew.selectpright))
        self.rightIcon.addGestureRecognizer(selectSecondPerson)
        rightIcon.userInteractionEnabled = true
        
        let selectFirstPerson =  UITapGestureRecognizer(target: self, action: #selector(enrollmentMembersRenew.selectpleft))
        self.leftIcon.addGestureRecognizer(selectFirstPerson)
        leftIcon.userInteractionEnabled = true
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_sync(dispatch_get_main_queue()){
                print(json["result"]["Groups"][0]["Members"])
                
                for x in 0..<self.memberjson.count{
                    for y in 0..<json["result"]["Groups"].count{
                        for z in 0..<json["result"]["Groups"][y]["Members"].count{
                            let a = String(self.memberjson[x]["SystemIdentifier"]) == String(json["result"]["Groups"][y]["Members"][z]["SystemIdentifier"])
                            let b = self.memberjson[x]["Gender"] == json["result"]["Groups"][y]["Members"][z]["Gender"]
                            
                            if a && b {
                                self.memberjson[x] = json["result"]["Groups"][y]["Members"][z]
                                self.memberjson[x]["ActiveState"] = true
                            }else{
                                if self.memberjson[x]["ActiveState"] != true{
                                    self.memberjson[x]["ActiveState"] = false
                                }
                            }
                        }
                    }
                }
                print(self.memberjson)
                self.assignMembers()
            }
        })
        
        
        enrollmentMembersMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70);
    }
    
    @IBAction func rightAddMoreClick(sender: AnyObject) {
        
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
    var afterArray : JSON = [[]]
    
    func addMemberToJson(relation : String) {
        var checkrelation = false
        for x in 0...self.memberjson.count {
            if self.memberjson[x]["SystemIdentifier"].stringValue == relation {
                if !checkrelation {
                    checkrelation = true
                    afterArray.arrayObject?.append(self.memberjson[x].object)
                }
                
            }
            
        }
    }
    
    @IBAction func leftAddMoreClick(sender: AnyObject) {
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let dateToSave = dateFormatter.stringFromDate(sender.date)
        switch datetype {
        case 1:
            leftDOB.text = dateToSave
            break
        case 2:
            leftDOM.text = dateToSave
            break
        case 3:
            rightDOB.text = dateToSave
            break
        case 4:
            leftDOM.text = dateToSave
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
        print("left click")
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
    
    @IBAction func rightActionArrow(sender: AnyObject) {
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
            self.enrollmentMembersMainView.viewWithTag(2)?.hidden = true
            for x in 8...12 {
                let txtfield = self.enrollmentMembersMainView.viewWithTag(x) as? UITextField
                txtfield?.hidden = true
            }
        }
        
    }
    
    @IBAction func leftActionArrow(sender: AnyObject) {
        self.enrollmentMembersMainView.viewWithTag(2)?.hidden = false
        for x in 8...12 {
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
    
    
    func selectpright() {
        if self.rightTick.hidden {
            self.rightTick.hidden = false
            memberjson[page+1]["ActiveState"] = true

        }else{
            self.rightTick.hidden = true
            memberjson[page+1]["ActiveState"] = false

        }
        
    }
    func selectpleft() {
        if self.leftTick.hidden {
            self.leftTick.hidden = false
            memberjson[page]["ActiveState"] = true
        }else{
            self.leftTick.hidden = true
            memberjson[page]["ActiveState"] = false
        }
    }
    
    func assignMembers() {
//        self.leftMember = self.memberjson[page]
//        self.rightMember = self.memberjson[page + 1]
        assignText()
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
        }else{
            self.leftTick.hidden = true
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
        }else{
            self.rightTick.hidden = true
        }
        self.rightMemberName.text = self.memberjson[page+1]["RelationType"].stringValue
        self.rightFirstName.text = self.memberjson[page+1]["FirstName"].stringValue
        self.rightMiddelName.text = self.memberjson[page+1]["MiddleName"].stringValue
        self.rightLastName.text = self.memberjson[page+1]["LastName"].stringValue
        self.rightDOB.text = self.memberjson[page+1]["DateOfBirth"].stringValue
        self.rightDOM.text = self.memberjson[page+1]["DateOfRelation"].stringValue
        
    }
    
}

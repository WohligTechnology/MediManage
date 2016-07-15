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
    
    var newjson : JSON = ["LastName":"","Gender":"1","SystemIdentifier":"E"]
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
    @IBOutlet weak var rightAddMore: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        
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
    
    func selectpright() {
        if self.rightTick.hidden {
            self.rightTick.hidden = false
        }else{
            self.rightTick.hidden = true
        }
        
    }
    func selectpleft() {
        if self.leftTick.hidden {
            self.leftTick.hidden = false
        }else{
            self.leftTick.hidden = true
        }
    }
    
    func assignMembers() {
        self.leftMember = self.memberjson[page]
        self.rightMember = self.memberjson[page + 1]
        assignText()
    }
    
    func assignText() {
        switch (self.leftMember["RelationType"].stringValue) {
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
        
        if self.leftMember["ActiveState"] {
            self.leftTick.hidden = false
        }else{
            self.leftTick.hidden = true
        }
        self.leftMemberName.text = self.leftMember["RelationType"].stringValue
        self.leftFirstName.text = self.leftMember["FirstName"].stringValue
        self.leftMiddelName.text = self.leftMember["MiddleName"].stringValue
        self.leftLastName.text = self.leftMember["LastName"].stringValue
        self.leftDOB.text = self.leftMember["DateOfBirth"].stringValue
        
        switch (self.rightMember["RelationType"].stringValue) {
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
        if self.rightMember["ActiveState"] {
            print(self.rightMember["ActiveState"])
            self.rightTick.hidden = false
        }else{
            self.rightTick.hidden = true
        }
        self.rightMemberName.text = self.rightMember["RelationType"].stringValue
        self.rightFirstName.text = self.rightMember["FirstName"].stringValue
        self.rightMiddelName.text = self.rightMember["MiddleName"].stringValue
        self.rightLastName.text = self.rightMember["LastName"].stringValue
        self.rightDOB.text = self.rightMember["DateOfBirth"].stringValue

        
    }
}

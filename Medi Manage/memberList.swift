//
//  memberList.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable class memberList: UIView {
    
    @IBOutlet weak var dummyButton: UIButton!
    @IBOutlet var memberListMainView: UIView!
    
    @IBOutlet weak var nameViewOne: UIView!
    @IBOutlet weak var dobViewOne: UIView!
    @IBOutlet weak var domViewOne: UIView!
    
    @IBOutlet weak var nameViewTwo: UIView!
    @IBOutlet weak var domViewTwo: UIView!
    @IBOutlet weak var dobViewTwo: UIView!
    
    
    @IBOutlet weak var tabWife: UIView!
    @IBOutlet weak var tabSon: UIView!
    @IBOutlet weak var tabDaughter: UIView!
    @IBOutlet weak var tabFather: UIView!
    @IBOutlet weak var tabMother: UIView!
    @IBOutlet weak var editDetails: UILabel!
    @IBOutlet weak var seceditDetails: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblDOM: UILabel!
    
    @IBOutlet weak var lblPName: UILabel!
    @IBOutlet weak var lblPDOB: UILabel!
    @IBOutlet weak var lblPDOM: UILabel!
    
    @IBOutlet weak var lblWife: UILabel!
    @IBOutlet weak var lblSon: UILabel!
     @IBOutlet weak var lblDaughter: UILabel!
    @IBOutlet weak var lblFather: UILabel!
    @IBOutlet weak var lblMother: UILabel!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
   
    
    
    var json2 : JSON = nil
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        
       tabGesture()
       
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
      
         self.json2 = json
            self.tabwifeclicked()
        })
        
    }
    // 1BA1DF
    
    var fullName : String = ""
    var firstname  : String = ""
    var lastName : String = ""
    var DOB : String = ""
    var DOM : String = ""
    func tabwifeclicked() {
         updateTab()
        
       UpdateTabs(lblWife, uiview:  tabWife)
        for x in 0..<7
        {
            let currRelation  = String(json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Wife":
            
            firstname =   String(json2["result"]["Groups"][0]["Members"][x]["FirstName"])
               lastName = String(json2["result"]["Groups"][0]["Members"][x]["LastName"])
              
                DOB = String(json2["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
              
              let DOM = String(json2["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
       
              fullName = firstname + " " + lastName
              FirstTabs(fullName,DatofBirth: DOB,Dateofmarriage:DOM)
            
                break
            
            default:
            break
            
            }
        }
    }
    
    
    
    
    
    
    
    
    func tabsonclicked (){
      updateTab()
        UpdateTabs(lblSon, uiview: tabSon)
           // tabSon.backgroundColor =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
        
        for x in 0..<7
        {       let currRelation  = String(json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Son":
                
                firstname =   String(json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(json2["result"]["Groups"][0]["Members"][x]["LastName"])
                
                DOB = String(json2["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
             DOM = String(json2["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                
                fullName = firstname + " " + lastName
          FirstTabs(fullName,DatofBirth: DOB,Dateofmarriage:DOM)
                
                break
                
            default:
                break
                
            }
            
            
            
        }
        
        
    
    }
    
    func tabdaughterclicked() {
       updateTab()
        UpdateTabs(lblDaughter, uiview: tabDaughter)
        for x in 0..<7
        {       let currRelation  = String(json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Daughter":
                
                firstname =   String(json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(json2["result"]["Groups"][0]["Members"][x]["LastName"])
                
                DOB = String(json2["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                 DOM = String(json2["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                
                fullName = firstname + " " + lastName
                 FirstTabs(fullName,DatofBirth: DOB,Dateofmarriage:DOM)
                
                break
                
            default:
                break
                
            }
            
        }
        
    }
    
    func tabfatherclicked(){
       updateTab()
         UpdateTabs(lblFather,uiview: tabFather)
        for x in 0..<7
        {       let currRelation  = String(json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Father":
                
                firstname =   String(json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(json2["result"]["Groups"][0]["Members"][x]["LastName"])
                
                DOB = String(json2["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                DOM = String(json2["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                
                fullName = firstname + " " + lastName
                  SecondsTabs(fullName,DatofBirth: DOB,Dateofmarriage:DOM)
                
                break
                
            default:
                break
                
            }
            
        }
    }
    
    func tabmotherclicked() {
       updateTab()
        UpdateTabs(lblMother,uiview: tabMother)
        for x in 0..<7
        {       let currRelation  = String(json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Mother":
                
                firstname =   String(json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(json2["result"]["Groups"][0]["Members"][x]["LastName"])
                
                DOB = String(json2["result"]["Groups"][0]["Members"][x]["DateOfBirth"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                DOM = String(json2["result"]["Groups"][0]["Members"][x]["DateOfRelation"]).stringByReplacingOccurrencesOfString("T00:00:00", withString: "")
                
                
                fullName = firstname + " " + lastName
               SecondsTabs(fullName,DatofBirth: DOB,Dateofmarriage:DOM)
                
                break
                
            default:
                break
                
            }
            
        }
    }
    
  
    func updateTab(){
   
           tabWife.backgroundColor =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
         lblWife.textColor  = UIColor.whiteColor()
      
        tabSon.backgroundColor    =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
         lblSon.textColor         = UIColor.whiteColor()
       
        tabDaughter.backgroundColor   =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
        lblDaughter.textColor           = UIColor.whiteColor()
        
        tabFather.backgroundColor     =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
          lblFather.textColor   = UIColor.whiteColor()
        
           tabMother.backgroundColor   =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
           lblMother.textColor   = UIColor.whiteColor()
        
    
        
    }

    func UpdateTabs (label :UILabel ,uiview :UIView)  {
    
    label.textColor =    UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
    uiview.backgroundColor = UIColor.whiteColor()
    }
    
    
    
    
    func fbtnclicked() {
    gMemberListController.performSegueWithIdentifier("memberlist", sender: nil)
        
     }
    
    func secbtnclicked(){
       gMemberListController.performSegueWithIdentifier("memberlist", sender: nil)
    }
    
    func FirstTabs(fullName : String,DatofBirth : String,Dateofmarriage: String)
    {
               lblName.text = fullName
               lblDOB.text = DatofBirth
               lblDOM.text = Dateofmarriage

    }
    
    func SecondsTabs(fullName : String,DatofBirth : String,Dateofmarriage: String)
    {
        lblPName.text = fullName
        lblPDOB.text = DatofBirth
        lblPDOM.text = Dateofmarriage
        
        
    }
    
    
    
    func addBottomBorder(color: UIColor, width: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(5, myView.frame.size.height, myView.frame.size.width - 10, width)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "memberList", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        scrollView.contentSize.height = 856
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.addSubview(sortnewview)
        self.addSubview(scrollView)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        memberListMainView.frame = CGRectMake(0, 70, self.frame.size.width, self.frame.size.height)
        
        dummyButton.layer.zPosition = 10000
        
        //add borders
        addBottomBorder(UIColor.grayColor(), width: 0.5, myView: nameViewOne)
        addBottomBorder(UIColor.grayColor(), width: 0.5, myView: dobViewOne)
        addBottomBorder(UIColor.grayColor(), width: 0.5, myView: domViewOne)
        addBottomBorder(UIColor.grayColor(), width: 0.5, myView: nameViewTwo)
        addBottomBorder(UIColor.grayColor(), width: 0.5, myView: dobViewTwo)
        addBottomBorder(UIColor.grayColor(), width: 0.5, myView: domViewTwo)
    }
    

    @IBAction func premiumcalculationCall(sender: AnyObject) {
        gMemberListController.performSegueWithIdentifier("premiumcalculation", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
 
    func tabGesture()  {
        let fbtnEdit = UITapGestureRecognizer(target: self, action: Selector("fbtnclicked"))
        editDetails.addGestureRecognizer(fbtnEdit)
        editDetails.userInteractionEnabled = true
        
        let secbtnEdit = UITapGestureRecognizer(target: self, action: Selector("secbtnclicked"))
       seceditDetails.addGestureRecognizer(secbtnEdit)
        seceditDetails.userInteractionEnabled = true

        
        
        let tabwife = UITapGestureRecognizer(target: self, action: Selector("tabwifeclicked"))
        tabWife.addGestureRecognizer(tabwife)
        tabWife.userInteractionEnabled = true
        
        let tabson = UITapGestureRecognizer(target: self, action: Selector("tabsonclicked"))
        tabSon.addGestureRecognizer(tabson)
        tabSon.userInteractionEnabled = true
        
        let tabdaughter = UITapGestureRecognizer(target: self, action: Selector("tabdaughterclicked"))
        tabDaughter.addGestureRecognizer(tabdaughter)
        tabDaughter.userInteractionEnabled = true
        
        let tabfather = UITapGestureRecognizer(target: self, action: Selector("tabfatherclicked"))
        tabFather.addGestureRecognizer(tabfather)
        tabFather.userInteractionEnabled = true
        
        let tabmother = UITapGestureRecognizer(target: self, action: Selector("tabmotherclicked"))
        tabMother.addGestureRecognizer(tabmother)
        tabMother.userInteractionEnabled = true
      
    }

    
    
}


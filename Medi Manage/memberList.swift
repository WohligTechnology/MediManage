//
//  memberList.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class memberList: UIView ,UIActionSheetDelegate{
    
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
    
    @IBOutlet weak var dropDownList: UIView!
    
    @IBOutlet weak var SumInsuredList: UIView!

    @IBOutlet weak var selectTopUP: UIView!
    
   
    var SumInsuredValue : Int = 0
    
    
    
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
      //print(json)
         self.json2 = json
      
        let insuredValue =  self.json2["result"]["Groups"][0]["SumInsuredList"][0]["SumInsuredValue"]
            print(insuredValue)
            self.tabwifeclicked()
        })
        
        
        
    }
    
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
            let currRelation  = String(describing: json2["result"]["Groups"][0]["Members"][x][1])
            
            switch currRelation{
                
            case "Wife":
            
            firstname =   String(describing: json2["result"]["Groups"][0]["Members"][x]["FirstName"])
               lastName = String(describing: json2["result"]["Groups"][0]["Members"][x]["LastName"])
              
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
    
 
    @IBAction func Calculation(_ sender: AnyObject) {
        
    }
    
    func tabsonclicked (){
      updateTab()
        UpdateTabs(lblSon, uiview: tabSon)
    
        for x in 0..<7
        {       let currRelation  = String(describing: json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Son":
                
                firstname =   String(describing: json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(describing: json2["result"]["Groups"][0]["Members"][x]["LastName"])
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
        {       let currRelation  = String(describing: json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Daughter":
                firstname =   String(describing: json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(describing: json2["result"]["Groups"][0]["Members"][x]["LastName"])
            
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
        {       let currRelation  = String(describing: json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Father":
                
                firstname =   String(describing: json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(describing: json2["result"]["Groups"][0]["Members"][x]["LastName"])
                
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
        {       let currRelation  = String(describing: json2["result"]["Groups"][0]["Members"][x]["RelationType"])
            
            switch currRelation{
                
            case "Mother":
                
                firstname =   String(describing: json2["result"]["Groups"][0]["Members"][x]["FirstName"])
                lastName = String(describing: json2["result"]["Groups"][0]["Members"][x]["LastName"])
                
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
         lblWife.textColor  = UIColor.white
      
        tabSon.backgroundColor    =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
         lblSon.textColor         = UIColor.white
       
        tabDaughter.backgroundColor   =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
        lblDaughter.textColor           = UIColor.white
        
        tabFather.backgroundColor     =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
          lblFather.textColor   = UIColor.white
        
           tabMother.backgroundColor   =  UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
           lblMother.textColor   = UIColor.white
        
    
        
    }

    func UpdateTabs (_ label :UILabel ,uiview :UIView)  {
    
    label.textColor =    UIColor(red: 21/255, green: 177/255, blue: 230/255, alpha: 255/255)
    uiview.backgroundColor = UIColor.white
    }
 
    func fbtnclicked() {
        let vc = gEnrollmentMembersController.storyboard?.instantiateViewController(withIdentifier: "EnrollmentMember") as! EnrollmentMembersController
        
        //  vc.RESULT = "Result"
        gMemberListGroupTableController.present(vc, animated: true, completion: nil)
        
     }
    
    func secbtnclicked(){
        
      
       
        
    }
    
    func FirstTabs(_ fullName : String,DatofBirth : String,Dateofmarriage: String)
    {
               lblName.text = fullName
               lblDOB.text = DatofBirth
               lblDOM.text = Dateofmarriage

    }
    
    func SecondsTabs(_ fullName : String,DatofBirth : String,Dateofmarriage: String)
    {
        lblPName.text = fullName
        lblPDOB.text = DatofBirth
        lblPDOM.text = Dateofmarriage
        
        
    }
    
   
    func addBottomBorder(_ color: UIColor, width: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 5, y: myView.frame.size.height, width: myView.frame.size.width - 10, height: width)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "memberList", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        scrollView.contentSize.height = 1000 //856
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(sortnewview)
        self.addSubview(scrollView)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRect(x: 0, y: 20, width: width, height: 50))
        self.addSubview(mainheader)
        
        memberListMainView.frame = CGRect(x: 0, y: 70, width: self.frame.size.width, height: self.frame.size.height)
        
        dummyButton.layer.zPosition = 10000
      //  premiumCalculation.layer.zPosition = 10000
        
        let calculationButton = UIButton(frame: CGRect(x: 0, y: 850, width: self.frame.size.width, height: 40))
        calculationButton.backgroundColor = UIColor.black
        calculationButton.setTitle("Premium Calculation", for: UIControlState())
        calculationButton.layer.zPosition = 9230
        
        
        let hell = UITapGestureRecognizer(target: self, action: #selector(memberList.Premcalculation))
        calculationButton.addGestureRecognizer(hell)
        calculationButton.isUserInteractionEnabled = true
        
        scrollView.addSubview(calculationButton)
        
        //add borders
        addBottomBorder(UIColor.gray, width: 0.5, myView: nameViewOne)
        addBottomBorder(UIColor.gray, width: 0.5, myView: dobViewOne)
        addBottomBorder(UIColor.gray, width: 0.5, myView: domViewOne)
        addBottomBorder(UIColor.gray, width: 0.5, myView: nameViewTwo)
        addBottomBorder(UIColor.gray, width: 0.5, myView: dobViewTwo)
        addBottomBorder(UIColor.gray, width: 0.5, myView: domViewTwo)
    }
    

    @IBAction func premiumcalculationCall(_ sender: AnyObject) {
        gMemberListGroupTableController.performSegue(withIdentifier: "premiumcalculation", sender: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
 
    func tabGesture()  {
        
      //  let calculation = UITapGestureRecognizer(target: self, action: Selector("Premcalculation"))
      //  premiumCalculation.addGestureRecognizer(calculation)
        //premiumCalculation.userInteractionEnabled = true
        
        let fbtnEdit = UITapGestureRecognizer(target: self, action: #selector(memberList.fbtnclicked))
        editDetails.addGestureRecognizer(fbtnEdit)
        editDetails.isUserInteractionEnabled = true
        let secbtnEdit = UITapGestureRecognizer(target: self, action: #selector(memberList.secbtnclicked))
       seceditDetails.addGestureRecognizer(secbtnEdit)
        seceditDetails.isUserInteractionEnabled = true
        let tabwife = UITapGestureRecognizer(target: self, action: #selector(memberList.tabwifeclicked))
        tabWife.addGestureRecognizer(tabwife)
        tabWife.isUserInteractionEnabled = true
        
        let tabson = UITapGestureRecognizer(target: self, action: #selector(memberList.tabsonclicked))
        tabSon.addGestureRecognizer(tabson)
        tabSon.isUserInteractionEnabled = true
        
        let tabdaughter = UITapGestureRecognizer(target: self, action: #selector(memberList.tabdaughterclicked))
        tabDaughter.addGestureRecognizer(tabdaughter)
        tabDaughter.isUserInteractionEnabled = true
        
        let tabfather = UITapGestureRecognizer(target: self, action: #selector(memberList.tabfatherclicked))
        tabFather.addGestureRecognizer(tabfather)
        tabFather.isUserInteractionEnabled = true
        
        let tabmother = UITapGestureRecognizer(target: self, action: #selector(memberList.tabmotherclicked))
        tabMother.addGestureRecognizer(tabmother)
        tabMother.isUserInteractionEnabled = true
      
    }

    
   func Premcalculation()
   {
 
    let myActionSheet = UIActionSheet()
    myActionSheet.addButton(withTitle: "Save")
    myActionSheet.addButton(withTitle: "Cancel")
    myActionSheet.show(in: gMemberListGroupTableController.view)
    
  //  gMemberListController.performSegueWithIdentifier("premiumcalculation", sender: nil)
   
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        switch (buttonIndex){
            
        case 0:
            print("Cancel")
        case 1:
            print("Save")
        case 2:
            print("Delete")
        default:
            print("Default")
         
            
        }
    }
    
    
}

//
//  InsuredMembersController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 13/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gInsuredMembersController: UIViewController!

class InsuredMembersController: UIViewController {
    
    let relations = ["Self", "Mother", "Father"]
    var selectedIndexPath: NSIndexPath?
    
    @IBOutlet weak var scrollView: UIScrollView!
    var verticalLayout : VerticalLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        gInsuredMembersController = self
        self.verticalLayout = VerticalLayout(width: self.view.frame.width);
        self.scrollView.insertSubview(self.verticalLayout, atIndex: 0)
        
        
        
        
        
        rest.DashboardDetails({(json:JSON) -> () in
            print(json)
            dispatch_async(dispatch_get_main_queue(), {
                for x in 0..<json["result"]["Groups"].count {
                    let groupView = insuredMembersAll(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 120))
                    self.verticalLayout.addSubview(groupView);
                    
                    groupView.totalSum.text = json["result"]["Groups"][x]["NetAmount"].stringValue;
                    groupView.topupSum.text = json["result"]["Groups"][x]["TopupAmount"].stringValue;
                    groupView.balance.text = json["result"]["Groups"][x]["TopupNetAmount"].stringValue;
                    
                    for y in 0..<json["result"]["Groups"][x]["Members"].count {
                        let membersView = member(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 163))
                        membersView.dob.text = json["result"]["Groups"][x]["Members"][y]["DateOfBirth"].stringValue;
                        membersView.firstName.text = json["result"]["Groups"][x]["Members"][y]["FirstName"].stringValue;
                        membersView.middleName.text = json["result"]["Groups"][x]["Members"][y]["MiddleName"].stringValue;
                        membersView.lastname.text = json["result"]["Groups"][x]["Members"][y]["LastName"].stringValue;
                        
                        
                        self.verticalLayout.addSubview(membersView);
                    }
                }
            });
            
//            self.verticalLayout.addSubview();
            self.verticalLayout.layoutSubviews()
        })
        
        // Do any additional setup after loading the view.
        navshow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
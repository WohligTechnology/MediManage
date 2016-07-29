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
        rest.DashboardDetails({(json:JSON) -> ()in
            print(json)
            
            for x in 0..<json["result"]["Groups"].count {
                
                let groupView = insuredMembersAll(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 120))
                
                self.verticalLayout.addSubview(groupView);
                
                for y in 0..<json["result"]["Groups"][x]["Members"].count {
                    let membersView = insuredMembersAll(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 163))
                    self.verticalLayout.addSubview(membersView);
                }
                
            }
            
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
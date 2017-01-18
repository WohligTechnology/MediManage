//
//  EnrollmentMembersController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON


var gEnrollmentMembersController: UIViewController!

//var viewEnrollmentMember: enrollmentMembers!

class EnrollmentMembersController: UIViewController {
    
    
    @IBOutlet weak var EnrollmentMemberUIView: UIView!
    
    func saveText(strText: NSString) {
        // labelText.text=strText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gEnrollmentMembersController = self
        LoadingOverlay.shared.showOverlay(self.view)
       
        
        navshow()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        selectedViewController = false
        
        if let default_tracker = GAI.sharedInstance().defaultTracker {
            #if DEBUG
                
                print("default tracker")
                
            #endif
        }
        
        // let tracker = GAI.sharedInstance().defaultTracker
        let tracker = GAI.sharedInstance().trackerWithTrackingId("UA-84646919-1")
        tracker.set(kGAIScreenName, value: "")
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


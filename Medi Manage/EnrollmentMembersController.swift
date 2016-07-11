//
//  EnrollmentMembersController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit


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
        
        let navigationLogo = UIImage(named: "logo_small")
        let navigationImageView = UIImageView(image: navigationLogo)
        self.navigationItem.titleView = navigationImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
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


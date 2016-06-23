//
//  CompleteProfileController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gCompleteProfileController: UIViewController!



class CompleteProfileController: UIViewController {

    public  var stremplyeeFullname :String = ""
    public  var EmployeeNo : String = ""
    public  var stremplyeeDOB : String = ""
    public var DateOfBirth : String = ""
    public var Email : String = ""
    public var EmployeeID : String = ""
    public var Password : String = ""
    public var FullName : String = ""
    public var FirstName : String = ""
    public var MiddleName : String = ""
    public var MaritalStatus : String = ""
    public var Gender : String = ""
    public var LastName : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gCompleteProfileController = self
      
        
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

//
//  HospitalSearchController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 23/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gHospitalSearchController: UIViewController!

class HospitalSearchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gHospitalSearchController = self
        selectedViewController = false
        navshow()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = false
        
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

//
//  PremiumCalculationController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gPremiumCalculationController: UIViewController!

class PremiumCalculationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gPremiumCalculationController = self
        selectedViewController = false
        LoadingOverlay.shared.showOverlay(self.view)
       
        navshow()
         self.navigationItem.setHidesBackButton(true, animated:true);
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
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

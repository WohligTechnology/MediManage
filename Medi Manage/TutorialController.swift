//
//  TutorialController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 24/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gTutorialController: UIViewController!

class TutorialController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gTutorialController = self
        self.displayNavBarActivity()
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

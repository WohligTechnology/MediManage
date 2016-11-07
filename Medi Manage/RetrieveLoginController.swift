//
//  RetrieveLoginController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gRetrieveLoginController: UIViewController!

class RetrieveLoginController: UIViewController {

    @IBOutlet weak var mobiletxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        gRetrieveLoginController = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GenerateOTP(_ sender: AnyObject) {
        isVarifiedToEdit = true
        print(isVarifiedToEdit)
        self.performSegue(withIdentifier: "toeditprofile", sender: nil)
    }

    @IBAction func BackBtn(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "toeditprofile", sender: nil)
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

//
//  CompleteProfileController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 12/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gCompleteProfileController: UIViewController!



class CompleteProfileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gCompleteProfileController = self
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.view.addSubview(statusBar)
//        LoadingOverlay.shared.showOverlay(self.view)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, myView.frame.size.height - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        textField.resignFirstResponder()
//    }

    @IBAction func editProfile(sender: AnyObject) {
        print(isVarifiedToEdit)
        self.performSegueWithIdentifier("requestOTP", sender: nil)
    }
    
}

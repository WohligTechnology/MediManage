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
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.view.addSubview(statusBar)
//        LoadingOverlay.shared.showOverlay(self.view)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: myView.frame.size.height - linewidth, width: width - 30, height: linewidth)
        myView.layer.addSublayer(border)
    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        textField.resignFirstResponder()
//    }

    @IBAction func editProfile(_ sender: AnyObject) {
        print(isVarifiedToEdit)
        self.performSegue(withIdentifier: "requestOTP", sender: nil)
    }
    
}

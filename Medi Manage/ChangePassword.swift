//
//  ChangePassword.swift
//  MediManage
//
//  Created by Jagruti  on 30/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePassword: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        //statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        statusBar.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1)
        self.view.addSubview(statusBar)
        navshow()
        self.currentPassword.delegate = self
        self.newPassword.delegate = self
        self.confPassword.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeMe(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentPassword.resignFirstResponder()
        newPassword.resignFirstResponder()
        confPassword.resignFirstResponder()
        return true
    }
    
    @IBAction func Submit(_ sender: AnyObject) {
        if currentPassword.text != "" && newPassword.text != "" && confPassword.text != "" {
            LoadingOverlay.shared.showOverlay(self.view)
            rest.changePassword(self.currentPassword.text!, np: self.newPassword.text!, cnp: self.confPassword.text!, completion: {(json:JSON) ->() in
                dispatch_get_main_queue().sync(DispatchQueue.main){
                    LoadingOverlay.shared.hideOverlayView()
                if json == 401 {
                    self.redirectToHome()
                }else{
                if json["state"] {
                    let dialog = UIAlertController(title: "Change Password", message: "Password changed successfully.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler:{
                        action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(dialog, animated: true, completion: nil)
                }else{
                    print("in side else")
                    Popups.SharedInstance.ShowPopup("Change Password", message: json["error_message"].stringValue)
                }
            }
                }
            })
        }else{
            Popups.SharedInstance.ShowPopup("Change Password", message: "Please Enter All Fields.")
            
        }
    }
}

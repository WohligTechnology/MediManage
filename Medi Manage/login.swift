//  login.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 04/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class login: UIView, UITextFieldDelegate {
    
    var TestId = "TestBetsol2"
    //mobile no 7208372744
    var TestPWD = "123456"
    
    
    @IBAction func signupCall(_ sender: AnyObject) {
        gLoginController.performSegue(withIdentifier: "signup", sender: nil)
    }
    
    
    @IBAction func retrieveLogin(_ sender: AnyObject) {
        gLoginController.performSegue(withIdentifier: "requestOTP", sender: nil)
    }
    
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        mobile.delegate = self
        password.delegate = self
//        mobile.text = TestId
//        password.text = TestPWD
    }
    
    func addPadding(_ width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.always
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "login", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview);
        
        addPadding(15, myView: mobile)
        addPadding(15, myView: password)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.resignFirstResponder()
        mobile.resignFirstResponder()
        return true
    }
    
    @IBAction func onLogin(_ sender: AnyObject) {
        if(mobile.text == "" || password.text == "")
        {
            Popups.SharedInstance.ShowPopup("Login", message: "Both Fields are Required")
        }
        else{
            LoadingOverlay.shared.showOverlay(gLoginController.view)
            
            rest.loginAlaomFire(mobile.text!, password: password.text!, completion: {(json:JSON) -> () in
                dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                    print(json)
                    //if(String(json["error"]) != "null")
                    LoadingOverlay.shared.hideOverlayView()
                    let i = 1
                    if let error = json["error"].string
                    {
                        let stError :String = String(describing: json ["error"])
                        
                        let dialog = UIAlertController(title: "Login", message: stError, preferredStyle: UIAlertControllerStyle.alert)
                        
                        dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.destructive, handler:{
                            action in
//                            self.mobile.text = ""
//                            self.password.text = ""
                            
                        }))
                        gLoginController.present(dialog, animated: true, completion: nil)
                    }
                    else
                    {
                        //  Popups.SharedInstance.ShowPopup("Welcome", message: "Login Successfull !")
                        Employee_API_KEY = String(describing: json["access_token"])
                        let def = UserDefaults.standardUserDefaults()
                        def.setObject(Employee_API_KEY, forKey: "access_token")
                        let dialog = UIAlertController(title: "Welcome", message: "Login Successfull!" ,preferredStyle: UIAlertControllerStyle.alert)
                        
                        dialog.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler:{
                            action in
                            
                            //let vc = gLoginController.storyboard?.instantiateViewControllerWithIdentifier("EnrollmentMember") as! EnrollmentMembersController
                            let vc = gLoginController.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBarController
                            
                            //  vc.RESULT = "Result"
                            gLoginController.present(vc, animated: true, completion: nil)
                            
                            // gLoginController.performSegueWithIdentifier("memberlist", sender: nil)
                            
                        }))
                        gLoginController.present(dialog,animated: true, completion: nil)
                        
                    }
                })
            })
        }
    }
    
    
}

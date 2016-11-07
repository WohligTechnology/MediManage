//
//  retrieveLogin.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 09/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class retrieveLogin: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var password: UITextField!
    var countryPickerView = UIPickerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addPadding(_ width: CGFloat, myView: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: myView.frame.height))
        myView.leftView = paddingView
        myView.leftViewMode = UITextFieldViewMode.always
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "retrieveLogin", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview)
        
        self.mobileNo.delegate = self
        self.password.delegate = self
        
        addPadding(15, myView: mobileNo)
        addPadding(15, myView: password)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mobileNo.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    @IBAction func loginCall(_ sender: AnyObject) {
        profileState = "Edit"
        let vc = gRetrieveLoginController.storyboard?.instantiateViewController(withIdentifier: "completeProfile") as! CompleteProfileController
        
        gRetrieveLoginController.present(vc, animated: true, completion: nil)
    }
    @IBAction func generateotpcall(_ sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(gRetrieveLoginController.view)
        forgotMobileNumber = String(self.mobileNo.text!)
        profilePassword = String(self.password.text!)
        rest.ClientSendOTP(String(self.mobileNo.text!), password: String(self.password.text!), completion: {(json:JSON) -> () in
            dispatch_get_main_queue().sync(DispatchQueue.main){
                print(json)
                LoadingOverlay.shared.hideOverlayView()
                if json["state"] {
                    let vc = gRetrieveLoginController.storyboard?.instantiateViewController(withIdentifier: "enterOTP") as! EnterOTPController
                    
                    gRetrieveLoginController.present(vc, animated: true, completion: nil)
                }
            }
        })
    }
}

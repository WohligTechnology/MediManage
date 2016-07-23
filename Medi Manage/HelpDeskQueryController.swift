//
//  HelpDeskQueryController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 21/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gHelpDeskQueryController: UIViewController!

class HelpDeskQueryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gHelpDeskQueryController = self
        let navigationLogo = UIImage(named: "logo_small")
        let navigationImageView = UIImageView(image: navigationLogo)
        
        self.navigationItem.titleView = navigationImageView
        
        let infoImage = UIImage(named: "settings")
        let imgWidth = 25
        let imgHeight = 25
        let button:UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: imgWidth, height: imgHeight))
        button.setBackgroundImage(infoImage, forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPopup () {
        
        let dialog = UIAlertController(title: "Login", message: "error", preferredStyle: UIAlertControllerStyle.Alert)
        
        dialog.addAction(UIAlertAction(title: "Try Again!!", style: UIAlertActionStyle.Destructive, handler:{
            action in
            
        }))
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

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

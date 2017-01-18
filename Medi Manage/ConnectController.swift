//
//  ConnectController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 21/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gConnectController: UIViewController!

class ConnectController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gConnectController = self
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderTitle.text = "Connect"
        self.view.addSubview(mainsubHeader)
        LoadingOverlay.shared.showOverlay(self.view)
        navshow()
        
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

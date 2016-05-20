//
//  SplashScreenController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 20/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {
    
    @IBOutlet var splashScreenMainView: UIView!
    @IBOutlet weak var splashImage: UIImageView!
    
    var backgroundImage: String!
    var pageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: backgroundImage)!)
        splashImage.image = UIImage(named: backgroundImage)

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

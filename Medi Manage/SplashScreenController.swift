//
//  SplashScreenController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 20/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController, UIGestureRecognizerDelegate {
    
    var backgroundImage: String!
    var pageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: backgroundImage)
        
        let myimage = UIImageView(frame: CGRectMake(0, 0, width, height))
        myimage.image = image
        self.view.addSubview(myimage)
        
        let button = UIButton(frame: CGRectMake(width / 2 - 95, height - 85, 200, 40))
        button.backgroundColor = UIColor.clearColor()
        button.layer.zPosition = 10000
        self.view.addSubview(button)
        
        let imageTap = UITapGestureRecognizer(target: self, action: Selector("imageTap:"))
        imageTap.delegate = self
        button.addGestureRecognizer(imageTap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTap(sender: UITapGestureRecognizer) {
        let im: TutorialController = storyboard?.instantiateViewControllerWithIdentifier("tutorialIdentifier") as! TutorialController //connectIdentifier
        self.presentViewController(im, animated: true, completion: nil)
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
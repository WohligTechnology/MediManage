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
        
        let myimage = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        myimage.image = image
        self.view.addSubview(myimage)
        
        let button = UIButton(frame: CGRect(x: width / 2 - 95, y: height - 85, width: 200, height: 40))
        button.backgroundColor = UIColor.clear
        button.layer.zPosition = 10000
        self.view.addSubview(button)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(SplashScreenController.imageTap(_:)))
        imageTap.delegate = self
        button.addGestureRecognizer(imageTap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTap(_ sender: UITapGestureRecognizer) {
        let im: TutorialController = storyboard?.instantiateViewController(withIdentifier: "tutorialIdentifier") as! TutorialController //connectIdentifier
        self.present(im, animated: true, completion: nil)
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

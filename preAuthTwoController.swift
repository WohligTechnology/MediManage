//
//  preAuthTwoController.swift
//  MediManage
//
//  Created by Pranay Joshi on 12/11/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class preAuthTwoController: UIViewController,UIScrollViewDelegate {
    
  
    @IBOutlet weak var patientNameLabel: UILabel!
   
   
    
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var preAuthorizationLabel: UILabel!
    
   
    @IBOutlet weak var dateofAdmissionLabel: UILabel!
    
    @IBOutlet weak var preAuthorizationTwo: UIView!
    @IBAction func cancelButton(sender: UIButton)
    
     {
        UIView.animateWithDuration(0.3, animations:{
            self.view.layoutIfNeeded()
            self.popUp.alpha = 0
            self.preAuthTwoScroll.alpha = 1
        })

        
    }

    @IBOutlet weak var preAuthTwoScroll: UIScrollView!
    @IBOutlet weak var requestReceived: UIImageView!
    
    @IBOutlet weak var query: UIImageView!
    
    @IBOutlet weak var pendingImage: UIImageView!
    @IBAction func showPopUp(sender: UIButton)
        
    {
        UIView.animateWithDuration(0.3, animations:{
            self.view.layoutIfNeeded()
            self.popUp.alpha = 1
            self.preAuthTwoScroll.alpha = 0.5
        })
    }

     override func viewDidLoad() {
        super.viewDidLoad()
        preAuthTwoScroll.contentSize.height = 667
        preAuthTwoScroll.contentSize.width = 375
        preAuthTwoScroll.minimumZoomScale = 0.03
        preAuthTwoScroll.maximumZoomScale = 1.0
        self.popUp.alpha = 0
        self.popUp.layer.zPosition = 10
        preAuthorizationTwo.addSubview(popUp)
        navshow()
        let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainSubHeader.subHeaderTitle.text = "Pre-Authorizations"
        mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        self.view.addSubview(mainSubHeader)
        
        func addBottomBorder(color: UIColor, linewidth: CGFloat, myView:UIView) {
            let border = CALayer()
            border.backgroundColor = color.CGColor
            //border.frame = CGRectMake(5, 10, width, 10)
            border.frame = CGRectMake(-5, myView.frame.size.height + 4 - linewidth, width - 30, linewidth)
            myView.layer.addSublayer(border)
            
            
        }
        
        addBottomBorder(UIColor.lightGrayColor(), linewidth: 0.5, myView: patientNameLabel)
        addBottomBorder(UIColor.darkGrayColor(), linewidth: 0.5, myView: preAuthorizationLabel)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: dateofAdmissionLabel)
        
        
        // Do any additional setup after loading the view.
        let line = drawDottedLine(frame: CGRectMake(67, 255, 1.5, 270))
        line.backgroundColor = UIColor.clearColor()
        line.layer.zPosition = 0
        preAuthorizationTwo.addSubview(line)
        
        requestReceived.layer.zPosition = 10
        query.layer.zPosition = 10
        pendingImage.layer.zPosition = 10
       
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class drawDottedLine1: UIView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() //Initializing the line
        CGContextSetLineWidth(context!, 5.0) //Set the points of the line
        CGContextSetStrokeColorWithColor(context!, mainBlueColor.CGColor) //set colour
        CGContextSetLineDash(context!, 0, [5.5], 1) // if equal lengths: [7.5 pts colored, 7.5 pts empty] else: [1,2] //Set Line dash
        CGContextSetLineCap(context!, CGLineCap(rawValue: 500)!) //line border radius
        CGContextMoveToPoint(context!, 0, 0) //initial point and end point on the x an y axes
        CGContextAddLineToPoint(context!, 0, 500)
        CGContextStrokePath(context!) //To actually make the line
        
    }
    
}


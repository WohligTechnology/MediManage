//
//  preAuthOneController.swift
//  Pods
//
//  Created by Pranay Joshi on 10/11/16.
//
//

import UIKit

class preAuthOneController: UIViewController, UIScrollViewDelegate {
    
  
    @IBOutlet weak var preAuthScroll: UIScrollView!
   
    @IBOutlet weak var patientName: UILabel!
    
    @IBOutlet weak var preAuthNo: UILabel!
    
    @IBOutlet weak var requestedAmount: UILabel!
    
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        preAuthScroll.contentSize.height = 675
        preAuthScroll.contentSize.width = 375
        preAuthScroll.minimumZoomScale = 0.03
        preAuthScroll.maximumZoomScale = 1.0
        navshow()
        let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainSubHeader.subHeaderTitle.text = "Pre-Authorizations"
        mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        self.view.addSubview(mainSubHeader)
        
        func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
            let border = CALayer()
            border.backgroundColor = color.CGColor
            //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
            border.frame = CGRectMake(-5, myView.frame.size.height + 4 - linewidth, width - 30, linewidth)
            myView.layer.addSublayer(border)
            
            
        }
        addBottomBorder(UIColor.lightGrayColor(), linewidth: 0.5, myView: patientName)
        addBottomBorder(UIColor.darkGrayColor(), linewidth: 0.5, myView: preAuthNo)
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: requestedAmount)
        // Do any additional setup after loading the view.
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

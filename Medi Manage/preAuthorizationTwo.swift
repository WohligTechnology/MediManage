//
//  preAuthorizationTwo.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 18/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

@IBDesignable class preAuthorizationTwo: UIView {
    
    @IBOutlet var preAuthorizationTwoMainView: UIView!
    
    @IBOutlet weak var patientNameView: UIView!
    @IBOutlet weak var preAuthorizationNoView: UIView!
    @IBOutlet weak var dateOfAdmissionView: UIView!
    @IBOutlet weak var requestedAmountView: UIView!
    
    @IBOutlet weak var requestReceivedImage: UIImageView!
    @IBOutlet weak var queryImage: UIImageView!
    @IBOutlet weak var initialApprovalImage: UIImageView!
    @IBOutlet weak var finalApprovalImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(-5, myView.frame.size.height + 4 - linewidth, width - 30, linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "preAuthorizationTwo", bundle: bundle)
        let preAuthorizationTwo = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        preAuthorizationTwo.frame = bounds
        preAuthorizationTwo.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(preAuthorizationTwo)
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "")
        mainsubHeader.subHeaderTitle.text = "PRE - AUTHORIZATIONS"
        self.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.addSubview(mainfooter)
        
        preAuthorizationTwoMainView.frame = CGRectMake(0, 120, self.frame.size.width, self.frame.size.height - 175)
        
        // add borders
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: patientNameView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: preAuthorizationNoView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: dateOfAdmissionView)
        addBottomBorder(UIColor.grayColor(), linewidth: 0.5, myView: requestedAmountView)
        
        // dotted lines for no use
        let line = drawDottedLine(frame: CGRectMake(50, 180, 1.5, 300))
        line.backgroundColor = UIColor.clearColor()
        line.layer.zPosition = 0
        preAuthorizationTwoMainView.addSubview(line)
        
        requestReceivedImage.layer.zPosition = 10
        queryImage.layer.zPosition = 10
        initialApprovalImage.layer.zPosition = 10
        finalApprovalImage.layer.zPosition = 10
    }
    @IBAction func queryFormCall(sender: AnyObject) {
        gPreAuthorizationTwoController.performSegueWithIdentifier("preAuthoTwoToQueryForm", sender: nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

class drawDottedLine: UIView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() //Initializing the line
        CGContextSetLineWidth(context, 5.0) //Set the points of the line
        CGContextSetStrokeColorWithColor(context, mainBlueColor.CGColor) //set colour
        CGContextSetLineDash(context, 0, [5.5], 1) // if equal lengths: [7.5 pts colored, 7.5 pts empty] else: [1,2] //Set Line dash
        CGContextSetLineCap(context, CGLineCap(rawValue: 500)!) //line border radius
        CGContextMoveToPoint(context, 0, 0) //initial point and end point on the x an y axes
        CGContextAddLineToPoint(context, 0, 1000)
        CGContextStrokePath(context) //To actually make the line
    }
    
}

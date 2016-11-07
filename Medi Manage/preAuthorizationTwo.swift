//
//  preAuthorizationTwo.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 18/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class preAuthorizationTwo: UIView {
    
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
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRect(x: -5, y: myView.frame.size.height + 4 - linewidth, width: width - 30, height: linewidth)
        myView.layer.addSublayer(border)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "preAuthorizationTwo", bundle: bundle)
        let preAuthorizationTwo = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        preAuthorizationTwo.frame = bounds
        preAuthorizationTwo.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(preAuthorizationTwo)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.addSubview(statusBar)
        
        let mainheader = header(frame: CGRect(x: 0, y: 20, width: width, height: 50))
        self.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 70, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "")
        mainsubHeader.subHeaderTitle.text = "PRE - AUTHORIZATIONS"
        self.addSubview(mainsubHeader)
        
        preAuthorizationTwoMainView.frame = CGRect(x: 0, y: 120, width: self.frame.size.width, height: self.frame.size.height - 125)
        
        // add borders
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: patientNameView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: preAuthorizationNoView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: dateOfAdmissionView)
        addBottomBorder(UIColor.gray, linewidth: 0.5, myView: requestedAmountView)
        
        // dotted lines for no use
        let line = drawDottedLine(frame: CGRect(x: 50, y: 180, width: 1.5, height: 300))
        line.backgroundColor = UIColor.clear
        line.layer.zPosition = 0
        preAuthorizationTwoMainView.addSubview(line)
        
        requestReceivedImage.layer.zPosition = 10
        queryImage.layer.zPosition = 10
        initialApprovalImage.layer.zPosition = 10
        finalApprovalImage.layer.zPosition = 10
    }
    @IBAction func queryFormCall(_ sender: AnyObject) {
        gPreAuthorizationTwoController.performSegue(withIdentifier: "preAuthoTwoToQueryForm", sender: nil)
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
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() //Initializing the line
        context?.setLineWidth(5.0) //Set the points of the line
        context?.setStrokeColor(mainBlueColor.cgColor) //set colour
        CGContextSetLineDash(context, 0, [5.5], 1) // if equal lengths: [7.5 pts colored, 7.5 pts empty] else: [1,2] //Set Line dash
        context?.setLineCap(CGLineCap(rawValue: 500)!) //line border radius
        context?.move(to: CGPoint(x: 0, y: 0)) //initial point and end point on the x an y axes
        context?.addLine(to: CGPoint(x: 0, y: 1000))
        context?.strokePath() //To actually make the line
    }
    
}

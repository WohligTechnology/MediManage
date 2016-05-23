//
//  HospitalSearchResultController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 19/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gHospitalSearchResultController: UIViewController!

class HospitalSearchResultController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBoxView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_five")
        mainsubHeader.subHeaderTitle.text = "HOSPITAL SEARCH"
        self.view.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: searchBoxView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! hospitalSearchResultUIViewCell
        //cell.indexNo.text = indexNo[indexPath.item]
        //cell.dateOfIntimation.text = dateOfIntimation[indexPath.item]
        //cell.patientName.text = patientName[indexPath.item]
        //cell.hospitalName.text = hospitalName[indexPath.item]
        //cell.doa.text = doa[indexPath.item]
        //cell.dod.text = dod[indexPath.item]
        //cell.diagnosis.text = diagnosis[indexPath.item]
        //cell.claimAmount.text = claimAmount[indexPath.item]
        cell.selectionStyle = .None
        
        //tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        
        if(indexPath.item % 2 != 0) {
            //cell.claimIntimationView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        let line = UIView(frame: CGRectMake(20, 0, 1, cell.hsCallView.frame.size.height))
        line.backgroundColor = UIColor.lightGrayColor()
        cell.hsCallView.addSubview(line)
        let line2 = UIView(frame: CGRectMake(145, 0, 1, cell.hsCallView.frame.size.height))
        line2.backgroundColor = UIColor.lightGrayColor()
        cell.hsCallView.addSubview(line2)
        let line3 = UIView(frame: CGRectMake(280, 0, 1, cell.hsCallView.frame.size.height))
        line3.backgroundColor = UIColor.lightGrayColor()
        cell.hsCallView.addSubview(line3)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(5, myView.frame.size.height - linewidth + 2, width - 50, linewidth)
        myView.layer.addSublayer(border)
    }
    @IBAction func inboxCall(sender: AnyObject) {
        self.performSegueWithIdentifier("benefitResultsToInbox", sender: nil)
    }

}

// MARK: - TableView Cell Class

class hospitalSearchResultUIViewCell: UITableViewCell {
    @IBOutlet weak var hsView: UIView!
    @IBOutlet weak var hsHospitalName: UILabel!
    @IBOutlet weak var hsHospitalLocation: UILabel!
    @IBOutlet weak var hsHospitalNo: UILabel!
    @IBOutlet weak var hsCallView: UIView!
}

class drawLine: UIView {
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, UIColor(red: 57/255, green: 66/255, blue: 106/255, alpha: 255/255).CGColor)
        //CGContextSetLineDash(context, 0, [7.5], 1)
        //CGContextSetLineCap(context, kCGLineCapRound)
        
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, 0, 45)
        
        CGContextStrokePath(context)
        
    }
}
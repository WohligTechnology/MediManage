//
//  HospitalSearchResultController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 19/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gHospitalSearchResultController: UIViewController!

class HospitalSearchResultController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchBoxView: UIView!
    var hospitals : JSON = ""
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var hoscount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        selectedViewController = false

        LoadingOverlay.shared.showOverlay(self.view)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_five")
        mainsubHeader.subHeaderTitle.text = "HOSPITAL SEARCH"
        self.view.addSubview(mainsubHeader)
        searchText.delegate = self
        
        // add borders
        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: searchBoxView)
        loadTable()
    }
    
    override func viewWillAppear(animated: Bool) {
        selectedViewController = false
        
    }
    
    func loadTable() {
        rest.Hospital(hospitalSearchText, completion: {(json:JSON) -> () in
            dispatch_async(dispatch_get_main_queue(),{
                if json == 401 {
                    self.redirectToHome()
                }else{
                LoadingOverlay.shared.hideOverlayView()
            self.hospitals = json["result"]["Results"]
            self.hoscount.text = json["result"]["Count"].stringValue
            self.searchTable.reloadData()
            }
            })
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchCalled()
        searchText.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchButton(sender: AnyObject) {
        searchCalled()
    }
    
    func searchCalled() {
        if self.searchText.text == "" {
            Popups.SharedInstance.ShowPopup("Hospital Search", message: "Please Enter Location & Name of Hospital")
        }else{
            hospitalSearchText = self.searchText.text
            LoadingOverlay.shared.showOverlay(self.view)
            loadTable()
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! hospitalSearchResultUIViewCell
        cell.selectionStyle = .None
        
        //tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        cell.hsHospitalName.text = hospitals[indexPath.row]["Name"].stringValue
        cell.hsHospitalLocation.text = hospitals[indexPath.row]["Address"].stringValue
        cell.hsHospitalNo.text = hospitals[indexPath.row]["Phone"].stringValue
        
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
//    @IBAction func inboxCall(sender: AnyObject) {
//        self.performSegueWithIdentifier("benefitResultsToInbox", sender: nil)
//    }

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
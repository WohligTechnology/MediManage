//
//  BenefitSummaryController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 23/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gBenefitSummaryController: UIViewController!

class BenefitSummaryController: UIViewController, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var singlePointContact: UILabel!
    @IBOutlet weak var insurer: UILabel!
    @IBOutlet weak var TPA: UILabel!
    @IBOutlet weak var summaryTable: UITableView!
    @IBOutlet weak var webViewpdf: UIWebView!
    var myBenefits : JSON = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLogo = UIImage(named: "logo_small")
        let navigationImageView = UIImageView(image: navigationLogo)
        self.navigationItem.titleView = navigationImageView
        let infoImage = UIImage(named: "settings")
        let imgWidth = 25
        let imgHeight = 25
        let button:UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: imgWidth, height: imgHeight))
        button.setBackgroundImage(infoImage, forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_three")
        mainsubHeader.subHeaderTitle.text = "BENEFIT SUMMARY"
        self.view.addSubview(mainsubHeader)
        
        gBenefitSummaryController = self
        
        
        rest.BenefitSummery({(json:JSON) -> () in
            print(json["result"]["SalientFeatures"])
            self.myBenefits = json["result"]
            self.singlePointContact.text = json["result"]["SinglePointofContact"].stringValue
            self.insurer.text = json["result"]["NameOfInsurer"].stringValue
            self.TPA.text = json["result"]["NameOfTPA"].stringValue
            self.summaryTable.estimatedRowHeight = 80
            self.summaryTable.rowHeight = UITableViewAutomaticDimension
            self.summaryTable.reloadData()
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myBenefits["SalientFeatures"].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! benefitTableCell
        cell.summaryText.text = self.myBenefits["SalientFeatures"][indexPath.row]["Text"].stringValue
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
           
        
        } else if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//                let pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("Discharge Summary", ofType:"pdf")!)
//        let request = NSURLRequest(URL: pdfLoc);
//        self.webViewpdf.loadRequest(request);
    }
    
    
    
    
}

class benefitTableCell: UITableViewCell {
    
    @IBOutlet weak var summaryText: UILabel!
}

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
    @IBOutlet weak var features: UILabel!
    
    var myBenefits : JSON = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 60, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_three")
        mainsubHeader.subHeaderTitle.text = "BENEFIT SUMMARY"
        self.view.addSubview(mainsubHeader)
        selectedViewController = false
        
        gBenefitSummaryController = self
        
        LoadingOverlay.shared.showOverlay(self.view)
        self.summaryTable.estimatedRowHeight = 68.0
        self.summaryTable.rowHeight = UITableViewAutomaticDimension
        
        rest.BenefitSummery({(json:JSON) -> () in
            dispatch_get_main_queue().sync(DispatchQueue.mainexecute: {
                if json == 401 {
                    self.redirectToHome()
                }else{
                    self.myBenefits = json["result"]
                    if json["result"]["SalientFeatures"].count == 0{
                        self.features.text = "No Features Available."
                    }
                    self.singlePointContact.text = json["result"]["SinglePointofContact"].stringValue
                    self.insurer.text = json["result"]["NameOfInsurer"].stringValue
                    self.TPA.text = json["result"]["NameOfTPA"].stringValue
                    self.summaryTable.reloadData()
                    LoadingOverlay.shared.hideOverlayView()
                }
            })
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myBenefits["SalientFeatures"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! benefitTableCell
        
        cell.summaryText.text = self.myBenefits["SalientFeatures"][indexPath.row]["Text"].stringValue
        cell.summaryText.adjustsFontSizeToFitWidth = true
        cell.summaryText.frame.size.height = 40
        cell.summaryText.numberOfLines = 0
        cell.summaryText.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.summaryText.sizeToFit()
        cell.summaryText.tag = indexPath.row
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
            
            
        } else if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
}

class benefitTableCell: UITableViewCell {
    
    @IBOutlet weak var summaryText: UILabel!
}

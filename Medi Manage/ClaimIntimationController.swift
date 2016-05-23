//
//  ClaimIntimationController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 19/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gClaimIntimationController: UIViewController!

class ClaimIntimationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let indexNo = ["1", "2", "3", "4", "5"]
    let dateOfIntimation = ["14/08/2015", "14/08/2015", "14/08/2015", "14/08/2015", "14/08/2015"]
    let patientName = ["Puneet Manocha", "Puneet Manocha", "Puneet Manocha",
                       "Puneet Manocha", "Puneet Manocha"]
    let hospitalName = ["Kohinoor Hospital, kurla", "Kohinoor Hospital, kurla", "Kohinoor Hospital, kurla", "Kohinoor Hospital, kurla", "Kohinoor Hospital, kurla"]
    let doa = ["15/08/2015", "15/08/2015", "15/08/2015", "15/08/2015", "15/08/2015"]
    let dod = ["17/08/2015", "17/08/2015", "17/08/2015", "17/08/2015", "17/08/2015"]
    let diagnosis = ["Fever", "Fever", "Fever", "Fever", "Fever"]
    let claimAmount = ["35,000", "35,000", "35,000", "35,000", "35,000"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_two")
        mainsubHeader.subHeaderTitle.text = "CLAIM INTIMATION"
        self.view.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! claimIntimationUIViewCell
        cell.indexNo.text = indexNo[indexPath.item]
        cell.dateOfIntimation.text = dateOfIntimation[indexPath.item]
        cell.patientName.text = patientName[indexPath.item]
        cell.hospitalName.text = hospitalName[indexPath.item]
        cell.doa.text = doa[indexPath.item]
        cell.dod.text = dod[indexPath.item]
        cell.diagnosis.text = diagnosis[indexPath.item]
        cell.claimAmount.text = claimAmount[indexPath.item]
        cell.selectionStyle = .None
        
        //tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        
        if(indexPath.item % 2 != 0) {
            cell.claimIntimationView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

    @IBAction func benefitSummaryCall(sender: AnyObject) {
        self.performSegueWithIdentifier("claimImmitationToBenefitSummary", sender: nil)
    }
}

// MARK: - TableView Cell Class

class claimIntimationUIViewCell: UITableViewCell {
    @IBOutlet weak var claimIntimationView: UIView!
    @IBOutlet weak var indexNo: UILabel!
    @IBOutlet weak var dateOfIntimation: UILabel!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var doa: UILabel!
    @IBOutlet weak var dod: UILabel!
    @IBOutlet weak var diagnosis: UILabel!
    @IBOutlet weak var claimAmount: UILabel!
}

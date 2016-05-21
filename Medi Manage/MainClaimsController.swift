//
//  MainClaimsController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 17/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gMainClaimsController: UIViewController!

class MainClaimsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let label1 = ["My Claims", "Claim Form", "Document Checklist",
                  "Claim Intimation", "Claim Process"]
    let label2 = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
    let image = ["claim_one", "claim_two", "claim_three", "claim_four", "claim_five"]
    
    @IBOutlet var mainClaimsMainView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gMainClaimsController = self
        // Do any additional setup after loading the view.
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_two")
        mainsubHeader.subHeaderTitle.text = "CLAIMS"
        self.view.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! mainClaimUIViewCell
        cell.claimTitle.text = label1[indexPath.item]
        cell.claimDescription.text = label2[indexPath.item]
        cell.claimImage.image = UIImage(named: image[indexPath.item])
        cell.selectionStyle = .None
        
        tableView.scrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        
        if(indexPath.item % 2 != 0) {
            cell.claimView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // sahi hai midhet :)
    }

    @IBAction func claimFormCall(sender: AnyObject) {
        self.performSegueWithIdentifier("mainClaimToClaimForm", sender: nil)
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

class mainClaimUIViewCell: UITableViewCell {
    @IBOutlet weak var claimView: UIView!
    @IBOutlet weak var claimImage: UIImageView!
    @IBOutlet weak var claimTitle: UILabel!
    @IBOutlet weak var claimDescription: UILabel!
}

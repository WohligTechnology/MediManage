//
//  DocumentChecklistController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 18/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gDocumentChecklistController: UIViewController!

class DocumentChecklistController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let image = ["claim_three", "claim_three", "claim_three", "claim_three"]
    let titleMain = ["Claim Form signed by employee", "Claim Form signed by employee",
                     "Claim Form signed by employee", "Claim Form signed by employee"]
    let desc = ["(All details must be filled in & should be signed by The EMPLOYEE only)",
                "(All details must be filled in & should be signed by The EMPLOYEE only)",
                "(All details must be filled in & should be signed by The EMPLOYEE only)",
                "(All details must be filled in & should be signed by The EMPLOYEE only)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "document_checklist")
        mainsubHeader.subHeaderTitle.text = "DOCUMENT CHECKLIST"
        self.view.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        
        dcDesc.font = UIFont(name: "Lato-Light", size: 10.0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! documentChecklistUIViewCell
        cell.dcTitle.text = titleMain[indexPath.item]
        cell.dcDesc.text = desc[indexPath.item]
        cell.dcImage.image = UIImage(named: image[indexPath.item])
        cell.selectionStyle = .None
        
        tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        
        if(indexPath.item % 2 != 0) {
            cell.dcView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

    @IBAction func myClaimsCall(sender: AnyObject) {
        self.performSegueWithIdentifier("dcToMyClaims", sender: nil)
    }
    
    @IBOutlet weak var dcDesc: UILabel!
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableView Cell Class

class documentChecklistUIViewCell: UITableViewCell {
    @IBOutlet weak var dcView: UIView!
    @IBOutlet weak var dcImage: UIImageView!
    @IBOutlet weak var dcTitle: UILabel!
    @IBOutlet weak var dcDesc: UILabel!
}
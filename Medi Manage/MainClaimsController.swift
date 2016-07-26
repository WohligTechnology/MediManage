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
    
    let label1 = ["Claim Form", "Document Checklist"]
    let label2 = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
    let image = ["claim_two", "claim_three"]
    
    @IBOutlet var mainClaimsMainView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gMainClaimsController = self
        // Do any additional setup after loading the view.
        
        
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
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_two")
        mainsubHeader.subHeaderTitle.text = "CLAIMS"
        self.view.addSubview(mainsubHeader)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        print("demo")
    }
}

class mainClaimUIViewCell: UITableViewCell {
    @IBOutlet weak var claimView: UIView!
    @IBOutlet weak var claimImage: UIImageView!
    @IBOutlet weak var claimTitle: UILabel!
    @IBOutlet weak var claimDescription: UILabel!
}

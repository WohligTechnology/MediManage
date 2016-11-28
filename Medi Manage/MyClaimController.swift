//
//  MyClaimController.swift
//  MediManage
//
//  Created by Pranay Joshi on 09/11/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON
var gmyClaimController: UIViewController!
class MyClaimController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
let claimName = ["Pre-Authorization", "Reimbursement"]
    let claimDescription = ["View the Cashless Hospitalization requests status.", "View the Re-Imbursement Claim status."]
    let claimImage = ["blue_arrow_right", "blue_arrow_right"]
    @IBOutlet var myClaimView: UIView!
    @IBOutlet weak var myClaimTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedViewController = false
        gmyClaimController = self
        navshow()
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        mainsubHeader.subHeaderTitle.text = "MY CLAIMS"
        self.view.addSubview(mainsubHeader)


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        selectedViewController = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myClaims") as! myclaimUIViewCell
        cell.myClaimTitle.text = claimName[indexPath.row]
        cell.myClaimDescription.text = claimDescription[indexPath.row]
        cell.myClaimImage.image = UIImage(named: claimImage[indexPath.item])
        cell.selectionStyle = .None
        
        tableView.scrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition(rawValue: 0)!, animated: true)
        if( indexPath.item % 2 != 1) {
            cell.claimCellView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }

     return cell
       
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myClaim = indexPath.item
        self.performSegueWithIdentifier("preAuth", sender: self)
//       if (myClaim == 0) {
//        
//    }else {
//    self.performSegueWithIdentifier("preAuth", sender: self)
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class myclaimUIViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var myClaimTitle: UILabel!
    
    @IBOutlet weak var myClaimDescription: UILabel!
    
        
    @IBOutlet weak var myClaimImage: UIImageView!
    
    @IBOutlet weak var claimCellView: UIView!
}

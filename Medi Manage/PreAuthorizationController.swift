//
//  PreAuthorizationController.swift
//  
//
//  Created by Pranay Joshi on 09/11/16.
//
//

import UIKit
var gPreAuthorizatonCntroller: UIViewController!
class PreAuthorizationController: UIViewController, UITableViewDelegate,UITableViewDataSource {
let preAuth = ["Active Claims", "Claims History"]
    let preAuthImage = ["blue_arrow_right", "blue_arrow_right"]
    @IBOutlet weak var preAuthTableView: UITableView!
    @IBOutlet var preAuthView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
gPreAuthorizatonCntroller = self
        selectedViewController = false
        navshow()
        if myClaim == 0 {
        
        let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        
        mainSubHeader.subHeaderTitle.text = ("Pre-Authorizations")
        mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
        self.view.addSubview(mainSubHeader)
               // Do any additional setup after loading the view.
        } else {
            let mainSubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
            
            mainSubHeader.subHeaderTitle.text = ("REIMBURSEMENT CLAIMS")
            mainSubHeader.subHeaderIcon.image = UIImage(named: "my_claim_icon")
            self.view.addSubview(mainSubHeader)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("preAuth") as! preAuthTableViewCell
        cell.preAuthName.text = preAuth[indexPath.item]
        cell.preAuthImage.image = UIImage(named: preAuthImage[indexPath.item])
        if (indexPath.item % 2 != 1) {
            cell.preAuthCellView.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
            tableView.scrollEnabled = true
            tableView.showsVerticalScrollIndicator = false

        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activeClaim = indexPath.item
        if (activeClaim == 0) {
            performSegueWithIdentifier("activeClaims", sender: self)
        }else {
           performSegueWithIdentifier("activeClaims", sender: self)
        }
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

class preAuthTableViewCell: UITableViewCell {
    
    @IBOutlet weak var preAuthImage: UIImageView!
    @IBOutlet weak var preAuthCellView: UIView!
    
    @IBOutlet weak var preAuthName: UILabel!
  
}

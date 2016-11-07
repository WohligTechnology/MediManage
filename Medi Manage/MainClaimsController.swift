//
//  MainClaimsController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 17/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        selectedViewController = false
        navshow()
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 60, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_two")
        mainsubHeader.subHeaderTitle.text = "CLAIMS"
        self.view.addSubview(mainsubHeader)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! mainClaimUIViewCell
        cell.claimTitle.text = label1[indexPath.item]
        cell.claimDescription.text = label2[indexPath.item]
        cell.claimImage.image = UIImage(named: image[indexPath.item])
        cell.selectionStyle = .none
        
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        
        if(indexPath.item % 2 != 0) {
            cell.claimView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        claim = indexPath.item
        
        if indexPath.row == 0 {
            LoadingOverlay.shared.showOverlay(self.view)
            rest.ClaimForm({(json:JSON) ->() in
                dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                    LoadingOverlay.shared.hideOverlayView()
                    let pdflink = json["result"].stringValue
                    let pdfURL = NSURL(string: pdflink.stringByAddingPercentEscapesUsingEncoding(String.Encoding.utf8)!)!
                    UIApplication.sharedApplication().openURL(pdfURL)
                    
                })
            })
        }else{
            self.performSegue(withIdentifier: "inDetail", sender: self)

        }
    }
}

class mainClaimUIViewCell: UITableViewCell {
    @IBOutlet weak var claimView: UIView!
    @IBOutlet weak var claimImage: UIImageView!
    @IBOutlet weak var claimTitle: UILabel!
    @IBOutlet weak var claimDescription: UILabel!
}

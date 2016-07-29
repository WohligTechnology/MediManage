//
//  InsuredMembersController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 13/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gInsuredMembersController: UIViewController!

class InsuredMembersController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let relations = ["Self", "Mother", "Father"]
    var selectedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        gInsuredMembersController = self
        rest.DashboardDetails({(json:JSON) -> ()in
            print(json)
        })
        
        // Do any additional setup after loading the view.
        navshow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relations.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! InsuredMemberCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! InsuredMemberCell).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return InsuredMemberCell.expandedHeight
//        }
        if indexPath == selectedIndexPath {
            return InsuredMemberCell.expandedHeight
        } else {
            return InsuredMemberCell.defaultHeight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("insuredcell", forIndexPath: indexPath) as! InsuredMemberCell
        
        cell.selectionStyle = .None
        
        cell.relationTitle.text = relations[indexPath.item]
        
        return cell
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

class InsuredMemberCell: UITableViewCell {
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var middleNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var sumView: UIView!
    @IBOutlet weak var topupSumView: UIView!
    @IBOutlet weak var balanceView: UIView!
    
    @IBOutlet weak var relationTitle: UILabel!
    
    class var expandedHeight: CGFloat { get { return 350 } }
    class var defaultHeight: CGFloat { get { return 40 } }
    
    func checkHeight() {
        firstNameView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
        middleNameView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
        lastNameView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
        dobView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
        sumView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
        topupSumView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
        balanceView.hidden = (frame.size.height < InsuredMemberCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        //removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
}
//
//  MemberListTableController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 02/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gMemberListTableController: UIViewController!

class MemberListTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let members = ["Wife", "Father", "Son", "Daughter"]
    var selectedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        gMemberListTableController = self
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
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
        (cell as! MemberListCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! MemberListCell).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        if indexPath.row == 0 {
        //            return InsuredMemberCell.expandedHeight
        //        }
        if indexPath == selectedIndexPath {
            return MemberListCell.expandedHeight
        } else {
            return MemberListCell.defaultHeight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("membercell", forIndexPath: indexPath) as! MemberListCell
        
        cell.selectionStyle = .None
        
        cell.memberName.text = members[indexPath.item]
        
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

class MemberListCell: UITableViewCell {
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var domView: UIView!
    @IBOutlet weak var editIcon: UIImageView!
    @IBOutlet weak var editText: UILabel!
    
    @IBOutlet weak var memberName: UILabel!
    
    class var expandedHeight: CGFloat { get { return 300 } }
    class var defaultHeight: CGFloat { get { return 40 } }
    
    func checkHeight() {
        nameView.hidden = (frame.size.height < MemberListCell.expandedHeight)
        dobView.hidden = (frame.size.height < MemberListCell.expandedHeight)
        domView.hidden = (frame.size.height < MemberListCell.expandedHeight)
        editIcon.hidden = (frame.size.height < MemberListCell.expandedHeight)
        editText.hidden = (frame.size.height < MemberListCell.expandedHeight)
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
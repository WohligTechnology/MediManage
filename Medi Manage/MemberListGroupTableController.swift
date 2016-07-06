//
//  MemberListTableController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 02/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var gMemberListGroupTableController: UIViewController!

class MemberListGroupTableController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource {
    
    var members : JSON = ""
    var selectedIndexPath: NSIndexPath?
    var memcount = 0

    @IBOutlet weak var ListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gMemberListGroupTableController = self
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_async(dispatch_get_main_queue(),{
                self.members = json
                self.memcount = self.members["result"]["Groups"].count
                self.ListTableView.reloadData()
            })
        })
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memcount)

        return 3
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! MemberListGroupCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! MemberListGroupCell).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        if indexPath.row == 0 {
        //            return InsuredMemberCell.expandedHeight
        //        }
        if indexPath == selectedIndexPath {
            return MemberListGroupCell.expandedHeight
        } else {
            return MemberListGroupCell.defaultHeight
        }
    }
    var injson : JSON = ""
    func memberClicked(sender: UIGestureRecognizer){
//        print(sender.view.data)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell",forIndexPath:indexPath) as! memberCollectionCell
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memlabel = UILabel()
        memlabel.text = "demo"
        let cell = tableView.dequeueReusableCellWithIdentifier("membergroupcell", forIndexPath: indexPath) as! MemberListGroupCell
        cell.selectionStyle = .None
        tableView.contentSize.height += 30
        
        let memberInGroup = self.members["result"]["Groups"][indexPath.item]
        
//        for item in 0..<memberInGroup["Members"].count {
//            print("in member")
//            print(item)
//            if String(memberInGroup["Members"][item]["RelationType"]) != "Self" {
//                let relationtab = relationView(frame: CGRectMake(0, 20, width, 50))
//                
//                relationtab.memberLabel.text = String(memberInGroup["Members"][item]["RelationType"])
//                relationtab.data = memberInGroup["Members"][item]
//                cell.memberGroup.addArrangedSubview(relationtab)
//                injson = memberInGroup["Members"][item]
//                
//                let memclick = UITapGestureRecognizer(target: self, action: #selector(self.memberClicked))
//                relationtab.data = injson
//                relationtab.addGestureRecognizer(memclick)
//                
////                relationtab.addTarget(self, action: #selector(self.textFieldDidChange(_:)) , forControlEvents: UIControlEvents.EditingChanged)
//
//            }
//            
//        
//        }        
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

class memberCollectionCell: UICollectionViewCell {
    
}

class MemberListGroupCell: UITableViewCell {
    
    
    //@IBOutlet weak var memberName: UILabel!
    
    class var expandedHeight: CGFloat { get { return 350 } }
    class var defaultHeight: CGFloat { get { return 350 } }
    
    @IBOutlet weak var memberGroup: UIStackView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberDob: UILabel!
    @IBOutlet weak var memberDom: UILabel!
    @IBOutlet weak var memberView: UIView!
    func checkHeight() {
        //nameView.hidden = (frame.size.height < MemberListCell.expandedHeight)
        //dobView.hidden = (frame.size.height < MemberListCell.expandedHeight)
        //domView.hidden = (frame.size.height < MemberListCell.expandedHeight)
//        editIcon.hidden = (frame.size.height < MemberListCell.expandedHeight)
//        editText.hidden = (frame.size.height < MemberListCell.expandedHeight)
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
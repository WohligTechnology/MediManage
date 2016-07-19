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

class MemberListGroupTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var members : JSON = ""
    var selectedIndexPath: NSIndexPath?
    var memcount = 0
    var storedOffsets = [Int: CGFloat]()


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
                self.members = json["result"]["Groups"]
                self.memcount = json["result"]["Groups"].count
                self.ListTableView.reloadData()
            })
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memcount)
        return memcount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MemberListGroupCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MemberListGroupCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
}
extension MemberListGroupTableController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members[collectionView.tag]["Members"].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as membercollectioncell
        
//        cell.backgroundColor = UIColor.blueColor()
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}


class MemberListGroupCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!


}

extension MemberListGroupCell {
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
    
//    @IBOutlet weak var lbl: UILabel!
    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        
        get {
            return collectionView.contentOffset.x
        }
    }
    

}
class membercollectioncell: UICollectionViewCell {
    
    @IBOutlet weak var namelbl: UILabel!
    
}
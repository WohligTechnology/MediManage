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
var gListTableView: UITableView!
var cnt = 0

class MemberListGroupTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var members : JSON = []
    var selectedIndexPath: NSIndexPath?
    var memcount = 0
    var storedOffsets = [Int: CGFloat]()
    var celltable : UITableViewCell?
    var tableindexpath: NSIndexPath!
    
    var insured = UIPickerView()
    var topup = UIPickerView()
    var result : JSON = []
    
    
    @IBOutlet weak var ListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gMemberListGroupTableController = self
        
        
//        
//        let navigationLogo = UIImage(named: "logo_small")
//        let navigationImageView = UIImageView(image: navigationLogo)
//        self.navigationItem.titleView = navigationImageView
//        let infoImage = UIImage(named: "settings")
//        let imgWidth = 25
//        let imgHeight = 25
//        let button:UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: imgWidth, height: imgHeight))
//        button.setBackgroundImage(infoImage, forState: .Normal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        
        gListTableView = ListTableView

        
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_async(dispatch_get_main_queue(),{
                print(json)
                self.result = json["result"]
                self.members = json["result"]["Groups"]
                self.memcount = self.members.count
                cnt = self.members.count
                self.ListTableView.reloadData()
            })
        })
        // dropdown list
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memcount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        celltable = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MemberListGroupCell
        
        return celltable!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MemberListGroupCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.setpickerViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.tag = indexPath.row
        tableViewCell.namelbl.text = members[0]["Members"][0]["FirstName"].stringValue
        tableViewCell.doblbl.text = members[0]["Members"][0]["DateOfBirth"].stringValue
        tableViewCell.domlbl.text = members[0]["Members"][0]["DateOfRelation"].stringValue
        tableViewCell.sumInsured.text = members[indexPath.row]["SelectedSumInsuredValue"].stringValue
        tableViewCell.topUp.text = members[indexPath.row]["SelectedTopupValue"].stringValue
        if !result["IsInEnrollmentPeriod"] {
            tableViewCell.sumInsured.enabled = false
            tableViewCell.topUp.enabled = false
        }
        
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard cell is MemberListGroupCell else { return }
        
//        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableindexpath = indexPath
    }
    
    // SUBMIT INSURED MEMBER LIST
    func convap (text : String) -> String {
        return text.stringByReplacingOccurrencesOfString("+", withString: "%2B")
    }
    
    
    @IBAction func submitSumInsuredAndTopUp(sender: AnyObject) {
//        var insuredJSON : JSON = ["PlanComposition":"","GroupComposition":"","SumInsuredValue":0,"TopupSumInsuredValue":0,"GroupType":0,"RelationType":""]
        var SI : JSON = []
        var TU : JSON = []
        for x in 0..<self.members.count {
            SI.arrayObject?.append(["PlanComposition":"\(result["PlanComposition"])",
                "GroupComposition":"\(members[x]["GroupComposition"])",
                "SumInsuredValue":"\(members[x]["SelectedSumInsuredValue"])",
                "TopupSumInsuredValue":0,
                "GroupType":"\(members[x]["GroupType"])",
                "RelationType":""])
            TU.arrayObject?.append(["PlanComposition":"\(convap(result["PlanComposition"].stringValue))",
                "GroupComposition":"\(convap(members[x]["GroupComposition"].stringValue))",
                "SumInsuredValue":0,
                "TopupSumInsuredValue":"\(members[x]["SelectedTopupValue"])",
                "GroupType":"\(members[x]["GroupType"])",
                "RelationType":""])
        }
        print(SI)
        rest.ChangeSI(SI, completion: {(json:JSON) -> ()in
            print("si send")
            print(json)
            print(TU)
            rest.ChangeTU(TU, completion: {(json:JSON) -> ()in
                print("tu send")
                print(json)
                self.performSegueWithIdentifier("toPremiumWay", sender: self)
            })
        })
        
        
    }
    
}

extension MemberListGroupTableController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let tableindexpath = NSIndexPath(forRow: pickerView.tag, inSection: 0)
        let cell = ListTableView.cellForRowAtIndexPath(tableindexpath) as! MemberListGroupCell

        if pickerView == cell.insured {
            return members[pickerView.tag]["SumInsuredList"].count
        }else{
            return members[pickerView.tag]["SumInsuredList"][selectedIndex]["TopupList"].count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let tableindexpath = NSIndexPath(forRow: pickerView.tag, inSection: 0)
        let cell = ListTableView.cellForRowAtIndexPath(tableindexpath) as! MemberListGroupCell
        
        if pickerView == cell.insured {
            return members[pickerView.tag]["SumInsuredList"][row]["SumInsuredValue"].stringValue
        }else{
            return members[pickerView.tag]["SumInsuredList"][selectedIndex]["TopupList"][row]["SumInsuredValue"].stringValue
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let tableindexpath = NSIndexPath(forRow: pickerView.tag, inSection: 0)
        let cell = ListTableView.cellForRowAtIndexPath(tableindexpath) as! MemberListGroupCell
        
        if pickerView == cell.insured {
            selectedIndex = row
            pickerView.reloadAllComponents()
            cell.sumInsured.text = members[pickerView.tag]["SumInsuredList"][row]["SumInsuredValue"].stringValue
            members[pickerView.tag]["SelectedSumInsuredValue"].stringValue = members[pickerView.tag]["SumInsuredList"][row]["SumInsuredValue"].stringValue
            
        }else{
            cell.topUp.text = members[pickerView.tag]["SumInsuredList"][selectedIndex]["TopupList"][row]["SumInsuredValue"].stringValue
            members[pickerView.tag]["SelectedTopupValue"].stringValue = members[pickerView.tag]["SumInsuredList"][selectedIndex]["TopupList"][row]["SumInsuredValue"].stringValue
        }
    }
    

}

extension MemberListGroupTableController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members[collectionView.tag]["Members"].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! membercollectioncell
        
        cell.namelbl.text = members[collectionView.tag]["Members"][indexPath.row]["RelationType"].stringValue
        //        cell.namelbl.text = String(collectionView.tag)
//        cell.layer.borderWidth = 0.5
//        cell.frame.size.width = 90
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = 80
        return CGSizeMake(collectionView.bounds.size.width / 2, CGFloat(height))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        collectionView.reloadData()
//        let cello = collectionView.cellForItemAtIndexPath(indexPath)
//        cello!.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
        
        let tableindexpath = NSIndexPath(forRow: collectionView.tag, inSection: 0)
        
        let cell = ListTableView.cellForRowAtIndexPath(tableindexpath) as! MemberListGroupCell
//        cell.backgroundColor = UIColor.magentaColor()

        cell.namelbl?.text = members[collectionView.tag]["Members"][indexPath.row]["FirstName"].stringValue
        cell.doblbl?.text = members[collectionView.tag]["Members"][indexPath.row]["DateOfBirth"].stringValue
        cell.domlbl?.text = members[collectionView.tag]["Members"][indexPath.row]["DateOfRelation"].stringValue
        
    }
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        let cello:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
//        cello.contentView.backgroundColor = UIColor.clearColor()
//    }
}

var toolBar = UIToolbar()
class MemberListGroupCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var doblbl: UILabel!
    @IBOutlet weak var domlbl: UILabel!
    @IBOutlet weak var topUp: UITextField!
    @IBOutlet weak var sumInsured: UITextField!
    @IBOutlet weak var hiddenindex: UILabel!
    
    var insured = UIPickerView()
    var topup = UIPickerView()
    var selectedindex = 0;
    
}

extension MemberListGroupCell {
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.reloadData()
    }
    func setpickerViewDataSourceDelegate<D: protocol<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        
        insured.delegate = dataSourceDelegate
        insured.dataSource = dataSourceDelegate
        insured.tag = row
        
        topup.delegate = dataSourceDelegate
        topup.dataSource = dataSourceDelegate
        topup.tag = row
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.donePicker))
        gListTableView.tag = row
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        self.sumInsured.inputView = insured
        self.sumInsured.inputAccessoryView = toolBar

        self.topUp.inputView = topup
        self.topUp.inputAccessoryView = toolBar
    }
    func donePicker(sender: UIBarButtonItem){
        print("sender")
        print(gListTableView.tag)
        for x in 0..<cnt {
            let tableindexpath = NSIndexPath(forRow: x, inSection: 0)
            let cell = gListTableView.cellForRowAtIndexPath(tableindexpath) as! MemberListGroupCell
            
            cell.sumInsured.resignFirstResponder()
            cell.topUp.resignFirstResponder()
        }
        
    }
    
}

class membercollectioncell: UICollectionViewCell {
    
    @IBOutlet weak var namelbl: UILabel!
    
}
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
var activeIndex = 0;

class MemberListGroupTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var members : JSON = []
    var selectedIndexPath: IndexPath?
    var memcount = 0
    var storedOffsets = [Int: CGFloat]()
    var celltable : UITableViewCell?
    var tableindexpath: IndexPath!
    
    var insured = UIPickerView()
    var topup = UIPickerView()
    var result : JSON = []
    
    
    @IBOutlet weak var ListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gMemberListGroupTableController = self
        
        navshow()
        gListTableView = ListTableView
        selectedViewController = false

        LoadingOverlay.shared.showOverlay(self.view)
        rest.findEmployeeProfile("Enrollments/Details",completion: {(json:JSON) -> ()in
            dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                if json == 401 {
                    self.redirectToHome()
                }else{
                print(json)
                self.result = json["result"]
                self.members = json["result"]["Groups"]
                self.memcount = self.members.count
                cnt = self.members.count
                self.ListTableView.reloadData()
                LoadingOverlay.shared.hideOverlayView()
                }
            })
        })
        // dropdown list
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        celltable = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemberListGroupCell
        
        return celltable!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? MemberListGroupCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.setpickerViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.tag = indexPath.row
        tableViewCell.namelbl.text = members[0]["Members"][0]["FirstName"].stringValue
        
        let fullNameArr = members[0]["Members"][0]["DateOfBirth"].stringValue.characters.split{$0 == "T"}.map(String.init)
        
        tableViewCell.doblbl.text = fullNameArr[0]
        
        if members[0]["Members"][0]["DateOfRelation"].stringValue != "" && members[0]["Members"][0]["DateOfRelation"].stringValue != "null" {
            let fullNameArr1 = members[0]["Members"][0]["DateOfRelation"].stringValue.characters.split{$0 == "T"}.map(String.init)
            tableViewCell.domlbl.text = fullNameArr1[0]
        }else{
            tableViewCell.domlbl.text = "-"
        }
        
        tableViewCell.sumInsured.text = members[indexPath.row]["SelectedSumInsuredValue"].stringValue
        tableViewCell.topUp.text = members[indexPath.row]["SelectedTopupValue"].stringValue
        if members[indexPath.row]["SelectedTopupValue"].stringValue == "0" {
            tableViewCell.topupView.isHidden = true
        }
        if !result["IsInEnrollmentPeriod"] {
            tableViewCell.sumInsured.isEnabled = false
            tableViewCell.topUp.isEnabled = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard cell is MemberListGroupCell else { return }
        
//        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableindexpath = indexPath
    }
    
    // SUBMIT INSURED MEMBER LIST
    func convap (_ text : String) -> String {
        return text.replacingOccurrences(of: "+", with: "%2B")
    }
    
    
    @IBAction func submitSumInsuredAndTopUp(_ sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(self.view)
        var SI : JSON = []
        var TU : JSON = []
        for x in 0..<self.members.count {
            SI.arrayObject?.append(["PlanComposition":"\(result["PlanComposition"])",
                "GroupComposition":"\(members[x]["GroupComposition"])",
                "SumInsuredValue":"\(members[x]["SelectedSumInsuredValue"])",
                "TopupSumInsuredValue":0,
                "GroupType":"\(members[x]["GroupType"])",
                "RelationType":""])
            TU.arrayObject?.append(["PlanComposition":"\(result["PlanComposition"])",
                "GroupComposition":"\(members[x]["GroupComposition"])",
                "SumInsuredValue":"\(members[x]["SelectedSumInsuredValue"])",
                "TopupSumInsuredValue":"\(members[x]["SelectedTopupValue"])",
                "GroupType":"\(members[x]["GroupType"])",
                "RelationType":""])
        }
        print(SI)
        rest.ChangeSI(SI, completion: {(json:JSON) -> ()in
            dispatch_get_main_queue().sync(DispatchQueue.mainexecute: {
            if json == 401 {
                self.redirectToHome()
            }else{
            rest.ChangeTU(TU, completion: {(json:JSON) -> ()in
                dispatch_get_main_queue().sync(DispatchQueue.mainexecute: {
                LoadingOverlay.shared.hideOverlayView()
                if json["state"] {
                self.performSegue(withIdentifier: "toPremiumWay", sender: self)
                }
                })
            })
        }
            })
        })
        
        
    }
    
}

extension MemberListGroupTableController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let tableindexpath = IndexPath(row: pickerView.tag, section: 0)
        let cell = ListTableView.cellForRow(at: tableindexpath) as! MemberListGroupCell

        if pickerView == cell.insured {
            return members[pickerView.tag]["SumInsuredList"].count
        }else{
            return members[pickerView.tag]["SumInsuredList"][selectedIndex]["TopupList"].count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let tableindexpath = IndexPath(row: pickerView.tag, section: 0)
        let cell = ListTableView.cellForRow(at: tableindexpath) as! MemberListGroupCell
        
        if pickerView == cell.insured {
            return members[pickerView.tag]["SumInsuredList"][row]["SumInsuredValue"].stringValue
        }else{
            return members[pickerView.tag]["SumInsuredList"][selectedIndex]["TopupList"][row]["SumInsuredValue"].stringValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let tableindexpath = IndexPath(row: pickerView.tag, section: 0)
        let cell = ListTableView.cellForRow(at: tableindexpath) as! MemberListGroupCell
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members[collectionView.tag]["Members"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! membercollectioncell
       
        if(indexPath.row == activeIndex) {
            cell.backgroundColor = UIColor.darkGray
        }
        else {
            cell.backgroundColor = mainBlueColor
        }
        
        cell.namelbl.text = members[collectionView.tag]["Members"][indexPath.row]["RelationType"].stringValue
        //        cell.namelbl.text = String(collectionView.tag)
//        cell.layer.borderWidth = 0.5
//        cell.frame.size.width = 90
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let height = 80
        return CGSize(width: collectionView.bounds.size.width / 2, height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        activeIndex  = indexPath.row;
        
        collectionView.reloadData()
        
        let tableindexpath = IndexPath(row: collectionView.tag, section: 0)
        
        let cell = ListTableView.cellForRow(at: tableindexpath) as! MemberListGroupCell
//        cell.backgroundColor = UIColor.magentaColor()
        
        let fullNameArr1 = members[collectionView.tag]["Members"][indexPath.row]["DateOfBirth"].stringValue.characters.split{$0 == "T"}.map(String.init)

        cell.namelbl?.text = members[collectionView.tag]["Members"][indexPath.row]["FirstName"].stringValue
        cell.doblbl?.text = fullNameArr1[0]
        if members[collectionView.tag]["Members"][indexPath.row]["DateOfRelation"].stringValue == "" || members[collectionView.tag]["Members"][indexPath.row]["DateOfRelation"].stringValue == "null" {
            cell.domlbl?.text = "-"
        }else{
            let fullNameArr1 = members[collectionView.tag]["Members"][indexPath.row]["DateOfRelation"].stringValue.characters.split{$0 == "T"}.map(String.init)
            cell.domlbl?.text = fullNameArr1[0]
        }
    
    }
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        let cello:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
//        cello.contentView.backgroundColor = UIColor.clearColor()
//    }
}

var toolBar = UIToolbar()
class MemberListGroupCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var doblbl: UILabel!
    @IBOutlet weak var domlbl: UILabel!
    @IBOutlet weak var topUp: UITextField!
    @IBOutlet weak var sumInsured: UITextField!
    @IBOutlet weak var hiddenindex: UILabel!
    @IBOutlet weak var topupView: UIView!
    
    var insured = UIPickerView()
    var topup = UIPickerView()
    var selectedindex = 0;
    
    @IBAction func editDetails(_ sender: AnyObject) {
        isAddMember = true
        let vc = gMemberListGroupTableController.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBarController
        
        gMemberListGroupTableController.present(vc, animated: true, completion: nil)
        

    }
}

//extension MemberListGroupCell {
//    func setCollectionViewDataSourceDelegate<D: (UICollectionViewDataSource & UICollectionViewDelegate)>(_ dataSourceDelegate: D, forRow row: Int) {
//        
//        collectionView.delegate = dataSourceDelegate
//        collectionView.dataSource = dataSourceDelegate
//        collectionView.tag = row
//        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
//        collectionView.reloadData()
//    }
//    func setpickerViewDataSourceDelegate<D: (UIPickerViewDataSource & UIPickerViewDelegate & UITextFieldDelegate)>(_ dataSourceDelegate: D, forRow row: Int) {
//        
//        insured.delegate = dataSourceDelegate
//        insured.dataSource = dataSourceDelegate
//        insured.tag = row
//        
//        topup.delegate = dataSourceDelegate
//        topup.dataSource = dataSourceDelegate
//        topup.tag = row
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
//        gListTableView.tag = row
//        
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        
//        toolBar.setItems([spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        
//        self.sumInsured.inputView = insured
//        self.sumInsured.inputAccessoryView = toolBar
//
//        self.topUp.inputView = topup
//        self.topUp.inputAccessoryView = toolBar
//    }
//    func donePicker(_ sender: UIBarButtonItem){
//        print("sender")
//        print(gListTableView.tag)
//        for x in 0..<cnt {
//            let tableindexpath = IndexPath(row: x, section: 0)
//            let cell = gListTableView.cellForRow(at: tableindexpath) as! MemberListGroupCell
//            
//            cell.sumInsured.resignFirstResponder()
//            cell.topUp.resignFirstResponder()
//        }
//        
//    }
//    
//}

class membercollectioncell: UICollectionViewCell {
    
    @IBOutlet weak var namelbl: UILabel!
    func active() {
        self.backgroundColor = mainBlueColor;
        
    }
    func deactive() {
        self.backgroundColor = UIColor.black;
    }
    
}

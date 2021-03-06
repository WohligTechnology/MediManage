//
//  HospitalSearchResultController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 19/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

var gHospitalSearchResultController: UIViewController!

class HospitalSearchResultController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var searchBoxView: UIView!
    var hospitals : JSON = ""
    var hospitalSearch: JSON!
    
    @IBOutlet weak var searchName: UITextField!
    @IBOutlet weak var hospitalView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var hoscount: UILabel!
    @IBOutlet weak var nodata: UILabel!
    var lat = ""
    var lng = ""
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        hospitalSearchText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        hospitalNameText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        navshow()
        selectedViewController = false
        
        LoadingOverlay.shared.showOverlay(self.view)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_five")
        mainsubHeader.subHeaderTitle.text = "HOSPITAL SEARCH"
        self.view.addSubview(mainsubHeader)
        searchText.delegate = self
        searchName.delegate = self
//        searchName.text = nil
        
        searchText.text = ""
        
        searchText.text = hospitalSearchText
        searchName.text = hospitalNameText
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //        locationManager.startUpdatingLocation()
        
        checkCoreLocationPermission()
        
//        searchTable.hidden
        
        // add borders
//        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: searchBoxView)
//        addBottomBorder(UIColor.blackColor(), linewidth: 0.5, myView: hospitalView)
        loadTable()
      
        
    }
    
    override func viewWillAppear(animated: Bool) {
        selectedViewController = false
        
    }
    
    func checkCoreLocationPermission() {
        print("in core")
        if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            print("in authorized")
            locationManager.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .NotDetermined {
            print("in notdetaermined")
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .Restricted {
            print("unauthorized")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print(coord)
        print(coord.latitude)
        print(coord.longitude)
        lat = String(coord.latitude)
        lng = String(coord.longitude)
        locationManager.stopUpdatingLocation()
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func loadTable() {
        rest.Hospital(hospitalSearchText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()), hospital: hospitalNameText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()), completion: {(json:JSON) -> () in
            dispatch_async(dispatch_get_main_queue(),{
                self.searchTable.reloadData()
                LoadingOverlay.shared.hideOverlayView()
                self.searchTable.reloadData()

                print(json)
                
                if json == 401 {
                    self.redirectToHome()
                }else if json == 1{
                    Popups.SharedInstance.ShowPopup("Hospital Search", message: "Some Error Occured.")

                }else{
                    self.hospitals = json["result"]["Results"]
                    self.hoscount.text = json["result"]["Count"].stringValue
                    self.hospitalSearch = json["result"]["Results"]
                    print("hospitalssearch\(self.hospitalSearch)")

                   
//                    self.searchText.text = self.hospitalSearch[0]["City"].stringValue
                    print("hellohospi\(self.hospitalSearch)")

                    
                    if json["result"]["Count"] == 0{
                        self.nodata.hidden = false
                        self.searchTable.hidden = true
                    }else{
                        self.nodata.hidden = true
                        self.searchTable.hidden = false
                    }
                    self.searchTable.reloadData()
                    
                    
                }
            })
        })
        hospitalNameText = ""
        hospitalSearchText = ""
//        self.searchName.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchCalled()
        searchText.resignFirstResponder()
        searchName.resignFirstResponder()
        return true
    }
//    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        searchName.text = ""
//       
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        searchName.text = ""
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchButton(sender: AnyObject) {
        //        locationManager.startUpdatingLocation()
        
        //        rest.getLocation({(json:JSON) ->() in
        //            dispatch_async(dispatch_get_main_queue(),{
        //                //            print(json)
        //                print(json["routes"][0]["legs"])
        //
        //                let saddrlat = "\(json["routes"][0]["legs"][0]["start_location"]["lat"])"
        //                let saddrlng = "\(json["routes"][0]["legs"][0]["start_location"]["lng"])"
        //                let daddrlat = "\(json["routes"][0]["legs"][0]["end_location"]["lat"])"
        //                let daddrlng = "\(json["routes"][0]["legs"][0]["end_location"]["lng"])"
        //
        //                let urlstring = "http://maps.google.com/maps?saddr=\(saddrlat),\(saddrlng)&daddr=\(daddrlat),\(daddrlng)"
        //                print(urlstring)
        //                if let url = NSURL(string:urlstring.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        //                {
        //                    UIApplication.sharedApplication().openURL(url)
        //                }
        //            })
        //        })
        //
        //
        //
        searchCalled()
    }
    
    func searchCalled() {
        if self.searchText.text == "" && self.searchName.text == ""{
            Popups.SharedInstance.ShowPopup("Hospital Search", message: "Please Enter Location & Name of Hospital")
        }
//        }else if self.searchText.text == "" || self.searchName.text != ""{
//        
//         Popups.SharedInstance.ShowPopup("Hospital Search", message: "Please Enter Location & Name of Hospital")
//        }
        
        else{
            hospitalSearchText = self.searchText.text
            hospitalNameText = self.searchName.text
            
            LoadingOverlay.shared.showOverlay(self.view)
            loadTable()
            
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! hospitalSearchResultUIViewCell
        cell.selectionStyle = .None
        
        //tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        cell.hsHospitalName.text = hospitals[indexPath.row]["Name"].stringValue
        cell.hsHospitalLocation.text = hospitals[indexPath.row]["Address"].stringValue
        cell.hsHospitalNo.text = hospitals[indexPath.row]["Phone"].stringValue
        cell.hospitalCall.tag = indexPath.row
        cell.locationDirection.tag = indexPath.row
        
        
        let HospitalCallGesture = UITapGestureRecognizer(target: self, action: #selector(self.callFirst(_:)))
        
        cell.hospitalCall.userInteractionEnabled = true
        cell.hospitalCall.addGestureRecognizer(HospitalCallGesture)
        
        let HospitalDirectionGesture = UITapGestureRecognizer(target: self, action: #selector(self.directions(_:)))
        
        cell.locationDirection.userInteractionEnabled = true
        cell.locationDirection.addGestureRecognizer(HospitalDirectionGesture)
        
        if(indexPath.item % 2 != 0) {
            //cell.claimIntimationView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        let line = UIView(frame: CGRectMake(20, 0, 1, cell.hsCallView.frame.size.height))
        line.backgroundColor = UIColor.lightGrayColor()
        //cell.hsCallView.addSubview(line)
        let line2 = UIView(frame: CGRectMake(145, 0, 1, cell.hsCallView.frame.size.height))
        line2.backgroundColor = UIColor.lightGrayColor()
        //cell.hsCallView.addSubview(line2)
        let line3 = UIView(frame: CGRectMake(280, 0, 1, cell.hsCallView.frame.size.height))
        line3.backgroundColor = UIColor.lightGrayColor()
        //cell.hsCallView.addSubview(line3)
        
        return cell
    }
    func callFirst(sender: UITapGestureRecognizer) {
        let phone = hospitals[sender.view!.tag]["Phone"].stringValue
        let fullPhone = phone.characters.split{$0 == "/"}.map(String.init)
        let formPhone = String(fullPhone[0]).characters.split{$0 == "-"}.map(String.init)
        let newPhone = formPhone[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + formPhone[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.callNumber(newPhone)
    }
    
    func directions(sender: UITapGestureRecognizer) {
        locationManager.startUpdatingLocation()
        print(hospitals[sender.view!.tag]["Address"].stringValue)
        rest.getLocation(hospitals[sender.view!.tag]["Address"].stringValue, completion: {(json:JSON) ->() in
            dispatch_async(dispatch_get_main_queue(),{
                print(json["results"][0]["geometry"]["location"])
                
                let saddrlat = self.lat
                let saddrlng = self.lng
                let daddrlat = "\(json["results"][0]["geometry"]["location"]["lat"])"
                let daddrlng = "\(json["results"][0]["geometry"]["location"]["lng"])"
                
                let urlstring = "http://maps.google.com/maps?saddr=\(saddrlat),\(saddrlng)&daddr=\(self.hospitals[sender.view!.tag]["Address"].stringValue)"
                print(urlstring)
                if let url = NSURL(string:urlstring.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
                {
                    UIApplication.sharedApplication().openURL(url)
                }
            })
        })
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
    
    func addBottomBorder(color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRectMake(0, myView.frame.size.height - linewidth + 2, width - 150, linewidth)
        
        myView.layer.addSublayer(border)
    }
    //    @IBAction func inboxCall(sender: AnyObject) {
    //        self.performSegueWithIdentifier("benefitResultsToInbox", sender: nil)
    //    }
    
}

// MARK: - TableView Cell Class

class hospitalSearchResultUIViewCell: UITableViewCell {
    @IBOutlet weak var hsView: UIView!
    @IBOutlet weak var hsHospitalName: UILabel!
    @IBOutlet weak var hsHospitalLocation: UILabel!
    @IBOutlet weak var hsHospitalNo: UILabel!
    @IBOutlet weak var hsCallView: UIView!
    @IBOutlet weak var hospitalCall: UIImageView!
    @IBOutlet weak var locationDirection: UIImageView!
}

class drawLine: UIView {
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context!, 2.0)
        CGContextSetStrokeColorWithColor(context!, UIColor(red: 57/255, green: 66/255, blue: 106/255, alpha: 255/255).CGColor)
        //CGContextSetLineDash(context, 0, [7.5], 1)
        //CGContextSetLineCap(context, kCGLineCapRound)
        
        CGContextMoveToPoint(context!, 0, 0)
        CGContextAddLineToPoint(context!, 0, 45)
        
        CGContextStrokePath(context!)
        
    }
}

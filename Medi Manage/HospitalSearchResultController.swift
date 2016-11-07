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
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var hoscount: UILabel!
    @IBOutlet weak var nodata: UILabel!
    var lat = ""
    var lng = ""
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        selectedViewController = false
        
        LoadingOverlay.shared.showOverlay(self.view)
        
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 60, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_five")
        mainsubHeader.subHeaderTitle.text = "HOSPITAL SEARCH"
        self.view.addSubview(mainsubHeader)
        searchText.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //        locationManager.startUpdatingLocation()
        
        checkCoreLocationPermission()
        
//        searchTable.hidden
        
        // add borders
        addBottomBorder(UIColor.black, linewidth: 0.5, myView: searchBoxView)
        loadTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = false
        
    }
    
    func checkCoreLocationPermission() {
        print("in core")
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            print("in authorized")
            locationManager.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .notDetermined {
            print("in notdetaermined")
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .restricted {
            print("unauthorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func loadTable() {
        rest.Hospital(hospitalSearchText, completion: {(json:JSON) -> () in
            dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
                LoadingOverlay.shared.hideOverlayView()

                print(json)
                if json == 401 {
                    self.redirectToHome()
                }else if json == 1{
                    Popups.SharedInstance.ShowPopup("Hospital Search", message: "Some Error Occured.")

                }else{
                    self.hospitals = json["result"]["Results"]
                    self.hoscount.text = json["result"]["Count"].stringValue
                    if json["result"]["Count"] == 0{
                        self.nodata.isHidden = false
                        self.searchTable.isHidden = true
                    }else{
                        self.nodata.isHidden = true
                        self.searchTable.isHidden = false
                    }
                    self.searchTable.reloadData()
                }
            })
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCalled()
        searchText.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchButton(_ sender: AnyObject) {
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
        if self.searchText.text == "" {
            Popups.SharedInstance.ShowPopup("Hospital Search", message: "Please Enter Location & Name of Hospital")
        }else{
            hospitalSearchText = self.searchText.text
            LoadingOverlay.shared.showOverlay(self.view)
            loadTable()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! hospitalSearchResultUIViewCell
        cell.selectionStyle = .none
        
        //tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        cell.hsHospitalName.text = hospitals[indexPath.row]["Name"].stringValue
        cell.hsHospitalLocation.text = hospitals[indexPath.row]["Address"].stringValue
        cell.hsHospitalNo.text = hospitals[indexPath.row]["Phone"].stringValue
        cell.hospitalCall.tag = indexPath.row
        cell.locationDirection.tag = indexPath.row
        
        
        let HospitalCallGesture = UITapGestureRecognizer(target: self, action: #selector(self.callFirst(_:)))
        
        cell.hospitalCall.isUserInteractionEnabled = true
        cell.hospitalCall.addGestureRecognizer(HospitalCallGesture)
        
        let HospitalDirectionGesture = UITapGestureRecognizer(target: self, action: #selector(self.directions(_:)))
        
        cell.locationDirection.isUserInteractionEnabled = true
        cell.locationDirection.addGestureRecognizer(HospitalDirectionGesture)
        
        if(indexPath.item % 2 != 0) {
            //cell.claimIntimationView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        let line = UIView(frame: CGRect(x: 20, y: 0, width: 1, height: cell.hsCallView.frame.size.height))
        line.backgroundColor = UIColor.lightGray
        //cell.hsCallView.addSubview(line)
        let line2 = UIView(frame: CGRect(x: 145, y: 0, width: 1, height: cell.hsCallView.frame.size.height))
        line2.backgroundColor = UIColor.lightGray
        //cell.hsCallView.addSubview(line2)
        let line3 = UIView(frame: CGRect(x: 280, y: 0, width: 1, height: cell.hsCallView.frame.size.height))
        line3.backgroundColor = UIColor.lightGray
        //cell.hsCallView.addSubview(line3)
        
        return cell
    }
    func callFirst(_ sender: UITapGestureRecognizer) {
        let phone = hospitals[sender.view!.tag]["Phone"].stringValue
        let fullPhone = phone.characters.split{$0 == "/"}.map(String.init)
        let formPhone = String(fullPhone[0]).characters.split{$0 == "-"}.map(String.init)
        let newPhone = formPhone[0].stringByTrimmingCharactersInSet(CharacterSet.whitespaceCharacterSet()) + formPhone[1].stringByTrimmingCharactersInSet(CharacterSet.whitespaceCharacterSet())
        self.callNumber(newPhone)
    }
    
    func directions(_ sender: UITapGestureRecognizer) {
        locationManager.startUpdatingLocation()
        print(hospitals[sender.view!.tag]["Address"].stringValue)
        rest.getLocation(hospitals[sender.view!.tag]["Address"].stringValue, completion: {(json:JSON) ->() in
            dispatch_get_main_queue().asynchronously(DispatchQueue.mainexecute: {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    func addBottomBorder(_ color: UIColor, linewidth: CGFloat, myView: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        //border.frame = CGRectMake(0, myView.frame.size.height - width, myView.frame.size.width, width)
        border.frame = CGRect(x: 5, y: myView.frame.size.height - linewidth + 2, width: width - 50, height: linewidth)
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
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setStrokeColor(UIColor(red: 57/255, green: 66/255, blue: 106/255, alpha: 255/255).cgColor)
        //CGContextSetLineDash(context, 0, [7.5], 1)
        //CGContextSetLineCap(context, kCGLineCapRound)
        
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: 0, y: 45))
        
        context?.strokePath()
        
    }
}

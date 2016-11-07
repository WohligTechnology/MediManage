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

class Downloader {
    class func load(_ URL: Foundation.URL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("Success: \(statusCode)")
                
                // This is your file-variable:
                // data
            }
            else {
                // Failure
                print("Failure: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
}

class InsuredMembersController: UIViewController {
    
    let relations = ["Self", "Mother", "Father"]
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var scrollView: UIScrollView!
    var verticalLayout : VerticalLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        gInsuredMembersController = self
        self.verticalLayout = VerticalLayout(width: self.view.frame.width);
        self.scrollView.insertSubview(self.verticalLayout, at: 0)
        selectedViewController = true
        let temp = UIView(frame: CGRect(x: 0, y: 0, width: widthGlo + 8, height: 15))
        self.verticalLayout.addSubview(temp);
        
        //The URL to Save
//        UIApplication.sharedApplication().openURL(NSURL(string: "http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf")!)

        
        rest.findEmployeeProfile("Enrollments/DashboardDetails",completion: {(json:JSON) -> () in
            print(json)
            DispatchQueue.main.asynchronously(DispatchQueue.mainexecute: {
                if json == 401 {
                    self.redirectToHome()
                }else{
                for x in 0..<json["result"]["Groups"].count {
                    let groupView = insuredMembersAll(frame: CGRect(x: 0, y: 0, width: widthGlo + 5 , height: 120))
                    self.verticalLayout.addSubview(groupView);
                    
                    groupView.totalSum.text = json["result"]["Groups"][x]["TotalSI"].stringValue;
                    groupView.topupSum.text = json["result"]["Groups"][x]["SelectedTopup"].stringValue;
                    groupView.balance.text = json["result"]["Groups"][x]["SelSI"].stringValue;
                    
                    for y in 0..<json["result"]["Groups"][x]["Members"].count {
                        let membersView = member(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 220))
                        
                        var fullNameArr = json["result"]["Groups"][x]["Members"][y]["DateOfBirth"].stringValue.characters.split{$0 == "T"}.map(String.init)
                        
                        membersView.dob.text = fullNameArr[0];
                        
                        membersView.firstName.text = json["result"]["Groups"][x]["Members"][y]["FirstName"].stringValue;
                        membersView.middleName.text = json["result"]["Groups"][x]["Members"][y]["MiddleName"].stringValue;
                        membersView.lastname.text = json["result"]["Groups"][x]["Members"][y]["LastName"].stringValue;
                        membersView.relation.text = json["result"]["Groups"][x]["Members"][y]["RelationType"].stringValue;
                        membersView.ecarddwld = json["result"]["Groups"][x]["Members"][y]["ID"].stringValue
                        membersView.isAvailable = json["result"]["Groups"][x]["Members"][y]["IsECardAvailable"].boolValue
                        if json["result"]["Groups"][x]["Members"][y]["IsECardAvailable"].boolValue {
                            membersView.ecardOutlate.isHidden = false
                        }else{
                            membersView.ecardOutlate.isHidden = true
                        }
                        self.verticalLayout.addSubview(membersView);
                        print(self.verticalLayout.frame.height);
                    }
                }
//                    let groupView = ButtonView(frame: CGRect(x: 0, y: 0, width: widthGlo + 5 , height: 50))
//                    self.verticalLayout.addSubview(groupView);
                    self.verticalLayout.layoutSubviews()

                    self.scrollView.contentSize = CGSize(width: self.verticalLayout.frame.width, height: self.verticalLayout.frame.height)
            }
            });
            
//            self.verticalLayout.addSubview();
            self.verticalLayout.layoutSubviews()
        })
        
        // Do any additional setup after loading the view.
        navshow()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

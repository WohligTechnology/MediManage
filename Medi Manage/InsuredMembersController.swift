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

class InsuredMembersController: UIViewController {
    
    let relations = ["Self", "Mother", "Father"]
    var selectedIndexPath: NSIndexPath?
    
    @IBOutlet weak var scrollView: UIScrollView!
    var verticalLayout : VerticalLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        gInsuredMembersController = self
        self.verticalLayout = VerticalLayout(width: self.view.frame.width);
        self.scrollView.insertSubview(self.verticalLayout, atIndex: 0)
        
//        checkSession()
        
        
        //The URL to Save
//        let yourURL = NSURL(string: "http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf")
//
//        if let pdfData = NSData(contentsOfURL: yourURL!) {
//            print("in document")
//            let resourceDocPath = NSHomeDirectory().stringByAppendingString("/Documents/yourPDF.pdf")
//            unlink(resourceDocPath)
//            pdfData.writeToFile(resourceDocPath, atomically: true)
//        }
        
        
        
        
//        //Create a URL request
//        let urlRequest = NSURLRequest(URL: yourURL!)
//        //get the data
//        let theData = try NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil)
//        
//        //Get the local docs directory and append your local filename.
//        var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last as? NSURL
//        
//        docURL = docURL?.URLByAppendingPathComponent( "myFileName.pdf")
//        
//        //Lastly, write your file to the disk.
//        theData?.writeToURL(docURL!, atomically: true)
        
        
        
        
        
        //The URL to Save
//        let yourURL = NSURL(string: "http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf")
//        //let urlPath: String = "YOUR_URL_HERE"
//        let request1: NSURLRequest = NSURLRequest(URL: yourURL!)
//        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//        
//        
//        do{
//            
//            let dataVal = try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
//            print(response)
//            do {
//                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(dataVal, options: []) as? NSDictionary {
//                    print("pdf response")
//                    
//                    print("Synchronous\(jsonResult)")
//                }
//            } catch let error as NSError {
//                print("error aaya")
//                print(error.localizedDescription)
//            }
//            
//            
//            
//        }catch let error as NSError
//        {
//            print(error.localizedDescription)
//        }
        
        
        
        
        
        
                
        rest.DashboardDetails({(json:JSON) -> () in
            print(json)
            dispatch_async(dispatch_get_main_queue(), {
                for x in 0..<json["result"]["Groups"].count {
                    let groupView = insuredMembersAll(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 120))
                    self.verticalLayout.addSubview(groupView);
                    
                    groupView.totalSum.text = json["result"]["Groups"][x]["NetAmount"].stringValue;
                    groupView.topupSum.text = json["result"]["Groups"][x]["TopupAmount"].stringValue;
                    groupView.balance.text = json["result"]["Groups"][x]["TopupNetAmount"].stringValue;
                    
                    for y in 0..<json["result"]["Groups"][x]["Members"].count {
                        let membersView = member(frame: CGRect(x: 0, y: 0, width: widthGlo, height: 220))
                        membersView.dob.text = json["result"]["Groups"][x]["Members"][y]["DateOfBirth"].stringValue;
                        membersView.firstName.text = json["result"]["Groups"][x]["Members"][y]["FirstName"].stringValue;
                        membersView.middleName.text = json["result"]["Groups"][x]["Members"][y]["MiddleName"].stringValue;
                        membersView.lastname.text = json["result"]["Groups"][x]["Members"][y]["LastName"].stringValue;
                        membersView.relation.text = json["result"]["Groups"][x]["Members"][y]["RelationType"].stringValue;
                        self.verticalLayout.addSubview(membersView);
                    }
                }
            });
            
//            self.verticalLayout.addSubview();
            self.verticalLayout.layoutSubviews()
        })
        
        // Do any additional setup after loading the view.
        navshow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
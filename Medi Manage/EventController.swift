//
//  EventController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/18/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var pastbutton: UIButton!
    
    @IBOutlet weak var upcomingTableView: UITableView!
    
    var titleString: String = "Upcoming Title"
    var tab: String = "upcoming"
    var data = 0
    
    var eventJSON: JSON!
    var upcomingArr: [JSON]!
    var pastArr: [JSON]!
    var eventArr: [JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor.redColor()
        LoadingOverlay.shared.showOverlay(self.view)
        
        self.eventArr = []
        
        rest.getAllEvents({(request) in
            if request == 1 {
                let alertController = UIAlertController(title: "No Connection", message:
                    "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                LoadingOverlay.shared.hideOverlayView()
                self.eventJSON = request
                self.upcomingArr = request["result"]["UpcomingEvents"].array!
                self.eventArr = self.upcomingArr
                self.pastArr = request["result"]["PastEvents"].array!
                print("my json: \(self.eventArr) - \(self.pastArr)")
                self.data = 1
                dispatch_async(dispatch_get_main_queue(), {
                    self.upcomingTableView.reloadData()
                })
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return eventArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        
        let upcell = tableView.dequeueReusableCellWithIdentifier("upcomingEventCell", forIndexPath: indexPath)
        upcell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let singleEventView = singleEvent(frame: CGRectMake(0, 0, self.view.frame.width, 180))
        
        if (eventArr[indexPath.section]["EventStartDate"].string != nil) {
            singleEventView.eventDate.text = eventArr[indexPath.section]["EventStartDate"].string!
            singleEventView.eventTitle.text = eventArr[indexPath.section]["EventName"].string!
            singleEventView.eventDescription.text = eventArr[indexPath.section]["EventDesc"].string!
            
            if (eventArr[indexPath.section]["ImageURL"].string != nil) {
                if let dataURL = NSURL(string: self.eventArr[indexPath.section]["ImageURL"].string!) {
                    do {
                        dispatch_async(dispatch_get_main_queue(), {
                            if let data = NSData(contentsOfURL: dataURL) {
                                let image = UIImage(data: data)
                                singleEventView.eventImage.image = image
                            }
                        })
                    }
                }
            }
            
            upcell.addSubview(singleEventView)
        }
        
        return upcell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tab == "upcoming" {
            let eventDetailController = storyboard?.instantiateViewControllerWithIdentifier("eventDetailController") as! EventDetailController
            eventDetailController.eventId = eventArr[indexPath.section]["ID"].int!
            self.navigationController?.pushViewController(eventDetailController, animated: true)
        } else if tab == "past" {
            let eventImageController = storyboard?.instantiateViewControllerWithIdentifier("eventImageController") as! EventImageController
            self.navigationController?.pushViewController(eventImageController, animated: true)
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }

    @IBAction func upcomingAction(sender: AnyObject) {
        upcomingButton.backgroundColor = mainBlueColor
        upcomingButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        pastbutton.backgroundColor = UIColor.whiteColor()
        pastbutton.setTitleColor(UIColor(red: 244 / 255, green: 109 / 255, blue: 30 / 255, alpha: 1), forState: .Normal)
        tab = "upcoming"
        
        if data == 1 {
            eventArr = upcomingArr
            upcomingTableView.reloadData()
        }
    }
    
    @IBAction func pastAction(sender: AnyObject) {
        pastbutton.backgroundColor = mainBlueColor
        pastbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        upcomingButton.backgroundColor = UIColor.whiteColor()
        upcomingButton.setTitleColor(UIColor(red: 244 / 255, green: 109 / 255, blue: 30 / 255, alpha: 1), forState: .Normal)
        tab = "past"
        
        if data == 1 {
            eventArr = pastArr
            upcomingTableView.reloadData()
        }
    }
}

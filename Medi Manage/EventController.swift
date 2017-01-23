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
    
    var eventJSON: JSON!
    var upcomingArr: [JSON]!
    var pastArr: [JSON]!
    var eventArr:[JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor.redColor()
        
        rest.getAllEvents({(request) in
            dispatch_async(dispatch_get_main_queue(), {
                self.eventJSON = request
                print("my json: \(self.eventJSON)")
            })
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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        
        let upcell = tableView.dequeueReusableCellWithIdentifier("upcomingEventCell", forIndexPath: indexPath)
        upcell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        let singleEventView = singleEvent(frame: CGRectMake(0, 0, self.view.frame.width, 180));
        singleEventView.eventDate.text = "16-12-2017"
        singleEventView.eventTitle.text = titleString
        singleEventView.eventDescription.text = "Mumbai Yoga Fest is an initiative to bring to all"
        singleEventView.eventImage.image = UIImage(named: "tutorial")
        upcell.addSubview(singleEventView)
        
        return upcell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tab == "upcoming" {
            let eventDetailController = storyboard?.instantiateViewControllerWithIdentifier("eventDetailController") as! EventDetailController
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
    
    func eventLoaded(json:JSON) {
        
        print(json)
        
        if(json == 1) {
            let alertController = UIAlertController(title: "No Connection", message:
                "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            eventJSON = json
            dispatch_async(dispatch_get_main_queue(),{
                self.upcomingTableView.reloadData()
            })
        }
        
    }

    @IBAction func upcomingAction(sender: AnyObject) {
        upcomingButton.backgroundColor = mainBlueColor
        upcomingButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        pastbutton.backgroundColor = UIColor.whiteColor()
        pastbutton.setTitleColor(mainBlueColor, forState: .Normal)
        
        tab = "upcoming"
        titleString = "Upcoming Title"
        eventArr = upcomingArr
        upcomingTableView.reloadData()
        
    }
    
    @IBAction func pastAction(sender: AnyObject) {
        pastbutton.backgroundColor = mainBlueColor
        pastbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        upcomingButton.backgroundColor = UIColor.whiteColor()
        upcomingButton.setTitleColor(mainBlueColor, forState: .Normal)
        
        tab = "past"
        titleString = "Past Title"
        eventArr = pastArr
        upcomingTableView.reloadData()
    }
}

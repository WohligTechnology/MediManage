//
//  EventController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/18/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class EventController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var pastbutton: UIButton!
    
    @IBOutlet weak var upcomingTableView: UITableView!
    
    var titleString: String = "Upcoming Title"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor.redColor()
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
        let eventDetailController = storyboard?.instantiateViewControllerWithIdentifier("eventDetailController") as! EventDetailController
        self.navigationController?.pushViewController(eventDetailController, animated: true)
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
        pastbutton.setTitleColor(mainBlueColor, forState: .Normal)
        
        titleString = "Upcoming Title"
        upcomingTableView.reloadData()
        
    }
    
    @IBAction func pastAction(sender: AnyObject) {
        pastbutton.backgroundColor = mainBlueColor
        pastbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        upcomingButton.backgroundColor = UIColor.whiteColor()
        upcomingButton.setTitleColor(mainBlueColor, forState: .Normal)
        
        titleString = "Past Title"
        upcomingTableView.reloadData()
    }
}
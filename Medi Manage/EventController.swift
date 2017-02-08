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
        
        if data == 0 {
            getEvents()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if data == 0 {
            getEvents()
        }
        
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
        
        let upcell = tableView.dequeueReusableCellWithIdentifier("upcomingEventCell", forIndexPath: indexPath)
        upcell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let singleEventView = singleEvent(frame: CGRectMake(0, 0, self.view.frame.width, 180))
        
        if (eventArr[indexPath.section]["EventStartDate"].string != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                singleEventView.eventDate.text = self.eventArr[indexPath.section]["EventStartDate"].stringValue
                singleEventView.eventTitle.text = self.eventArr[indexPath.section]["EventName"].stringValue
                let eventDescription = self.eventArr[indexPath.section]["EventDesc"].stringValue.stringByRemovingPercentEncoding
                
                do {
                    let decodeDescription = try NSMutableAttributedString(data: eventDescription!.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                    
                    let decoded = decodeDescription.string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    
                    let finalText = decoded.stringByReplacingOccurrencesOfString("\n", withString: "")
                    
                    singleEventView.eventDescription.text = finalText
//                    singleEventView.eventDescriptionWebView.loadHTMLString(decodeDescription, baseURL: nil)
                } catch {}
                
                if (self.eventArr[indexPath.section]["ImageURL"].string != nil) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        if let dataURL = NSURL(string: self.eventArr[indexPath.section]["ImageURL"].stringValue) {
                            do {
                                dispatch_async(dispatch_get_main_queue(), {
                                    if let data = NSData(contentsOfURL: dataURL) {
                                        let image = UIImage(data: data)
                                        singleEventView.eventImage.image = image
                                    }
                                })
                            }
                        }
                    })
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    upcell.addSubview(singleEventView)
                })
            })
        }
        
        return upcell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tab == "upcoming" {
            let eventDetailController = storyboard?.instantiateViewControllerWithIdentifier("eventDetailController") as! EventDetailController
            eventDetailController.eventId = eventArr[indexPath.section]["ID"].int!
            print(eventDetailController.eventId)
            self.navigationController?.pushViewController(eventDetailController, animated: true)
        } else if tab == "past" {
            let eventImageController = storyboard?.instantiateViewControllerWithIdentifier("eventImageController") as! EventImageController
            eventImageController.eventId = eventArr[indexPath.section]["ID"].int!
            print(eventImageController.eventId)
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
        upcomingTableView.alpha = 0
        tab = "upcoming"
        
        if data == 1 {
            eventArr = upcomingArr
            upcomingTableView.reloadData()
            upcomingTableView.alpha = 1
        }
    }
    
    @IBAction func pastAction(sender: AnyObject) {
        pastbutton.backgroundColor = mainBlueColor
        pastbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        upcomingButton.backgroundColor = UIColor.whiteColor()
        upcomingButton.setTitleColor(UIColor(red: 244 / 255, green: 109 / 255, blue: 30 / 255, alpha: 1), forState: .Normal)
        upcomingTableView.alpha = 0
        tab = "past"
        
        if data == 1 {
            eventArr = pastArr
            upcomingTableView.reloadData()
            upcomingTableView.alpha = 1
        }
    }
    
    func getEvents() {
        rest.getAllEvents({(request) in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                if request == 1 {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertController = UIAlertController(title: "No Connection", message:
                            "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                } else {
                    self.eventJSON = request
                    if self.eventJSON["result"] == [] {
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "No Data", message:
                                "Please try again later", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                                self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    } else {
                        if (request["result"]["UpcomingEvents"].array != nil || request["result"]["PastEvents"].array != nil) {
                            self.upcomingArr = request["result"]["UpcomingEvents"].array!
                            self.eventArr = self.upcomingArr
                            self.pastArr = request["result"]["PastEvents"].array!
                            print("my json: \(self.eventArr) - \(self.pastArr)")
                            self.data = 1
                            dispatch_async(dispatch_get_main_queue(), {
                                LoadingOverlay.shared.hideOverlayView()
                                self.upcomingTableView.reloadData()
                            })
                        } else {
                            dispatch_async(dispatch_get_main_queue(), {
                                //let alertController = UIAlertController(title: "Something went wrong", message:
                                    //"Please signin again", preferredStyle: UIAlertControllerStyle.Alert)
                                //alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                                //self.presentViewController(alertController, animated: true, completion: nil)
                                
                                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginc") as! LoginController
                                self.navigationController?.pushViewController(vc, animated: true)
                            })
                            
                        }
                    }
                }
            })
        })
    }
}

//
//  EventDetailController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/19/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class EventDetailController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var eventId: Int!
    var verticalLayout: VerticalLayout!
    var descriptionView: eventDescription!
    var eventDetailJSON: JSON!
    var likeType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        LoadingOverlay.shared.showOverlay(self.view)
        
        scrollView.contentSize.height = self.view.frame.height
        
        verticalLayout = VerticalLayout(width: self.view.frame.width)
        verticalLayout.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        scrollView.addSubview(verticalLayout)

        eventDetailAPI(eventId)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addHeightToLayout() {
        self.verticalLayout.layoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.verticalLayout.frame.width, height: self.verticalLayout.frame.height)
    }
    
    func eventMapView(imageUrl: String) -> UIView {
        let mapView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        mapView.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        
        let mapString = "https://maps.googleapis.com/maps/api/staticmap?center=\(imageUrl)&zoom=13&size=414x250&maptype=roadmap&markers=color:red"
        let mapStaticUrl = NSURL(string: mapString)
        
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        imageview.contentMode = .ScaleAspectFill
        imageview.userInteractionEnabled = true
//        imageview.accessibilityLabel = imageUrl
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.openMaps(_:)))
        singleTap.numberOfTapsRequired = 1
        imageview.addGestureRecognizer(singleTap)
        if let dataURL = NSURL(string: mapString) {
            do {
                dispatch_async(dispatch_get_main_queue(), {
                    if let data = NSData(contentsOfURL: dataURL) {
                        let image = UIImage(data: data)
                        imageview.image = image
                    }
                })
            }
        }
        mapView.addSubview(imageview)
        
//        let mapurl = NSURL(string: "http://maps.google.com/maps?q=\(imageUrl)")
//        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
//        webView.loadRequest(NSURLRequest(URL: mapStaticUrl!))
//        mapView.addSubview(webView)
        
        return mapView
    }
    
    func eventDetailView(name: String, location: String, dateFrom: String, dateTo: String, dateTime: String) -> UIView {
        let detailView = eventDetail(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 150))
        detailView.backgroundColor = UIColor.whiteColor()
        detailView.name.text = name
        detailView.location.text = location
        detailView.dateFrom.text = dateFrom
        detailView.dateTo.text = dateTo
        detailView.dateTime.text = dateTime
        
        addShadow(detailView)
        return detailView
    }
    
    func eventRegistrationView(dateFrom: String, dateTo: String) -> UIView {
        let registrationView = eventRegistration(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 75))
        registrationView.dateFrom.text = dateFrom
        registrationView.dateTo.text = dateTo
        
        addShadow(registrationView)
        return registrationView
    }
    
    func eventDescriptionView(descriptionText: String) -> UIView {
        descriptionView = eventDescription(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 45))
        addShadow(descriptionView)
        
        let decodedDescription = descriptionText.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        descriptionView.descriptionText.text = decodedDescription
        descriptionView.descriptionText.alpha = 0
        
        descriptionView.descriptionWebView.loadHTMLString(decodedDescription, baseURL: nil)
        descriptionView.descriptionWebView.alpha = 0
        
        descriptionView.arrowButton.tag = 1
        descriptionView.arrowButton.addTarget(self, action: #selector(descriptionArrow(_:)), forControlEvents: .TouchUpInside)
        
        return descriptionView
    }
    
    func registerButton() -> UIButton {
        var registerButtonView = UIButton()
        var registerLabel = UILabel()
        if eventDetailJSON["IsRegistered"] {
            registerButtonView = UIButton(frame: CGRect(x: self.view.frame.width - 130, y: 20, width: 120, height: 40))
            registerButtonView.backgroundColor = UIColor(red: 244 / 255, green: 109 / 255, blue: 30 / 255, alpha: 1)
            registerButtonView.layer.cornerRadius = 5.0
            registerButtonView.clipsToBounds = true
            
            registerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: registerButtonView.frame.width - 20, height: registerButtonView.frame.height))
            registerLabel.font = UIFont(name: "Aviner Roman", size: 16)
            registerLabel.textColor = UIColor.whiteColor()
        
            registerButtonView.enabled = false
            registerLabel.text = "REGISTERED"
        } else {
            registerButtonView = UIButton(frame: CGRect(x: self.view.frame.width - 110, y: 20, width: 100, height: 40))
            registerButtonView.backgroundColor = UIColor(red: 244 / 255, green: 109 / 255, blue: 30 / 255, alpha: 1)
            registerButtonView.layer.cornerRadius = 5.0
            registerButtonView.clipsToBounds = true
            
            registerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: registerButtonView.frame.width - 20, height: registerButtonView.frame.height))
            registerLabel.font = UIFont(name: "Aviner Roman", size: 16)
            registerLabel.textColor = UIColor.whiteColor()
            
            registerButtonView.enabled = true
            registerLabel.text = "REGISTER"
            registerButtonView.addTarget(self, action: #selector(self.register(_:)), forControlEvents: .TouchUpInside)
        }
        
        registerButtonView.addSubview(registerLabel)
        return registerButtonView
    }
    
    func spaceView() -> UIView {
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        spaceView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        return spaceView
    }
    
    func subHeaderView(name: String) -> UIView {
        let headerView = eventHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        headerView.title.text = name
        
        headerView.share.setTitle(name, forState: .Application)
        headerView.share.addTarget(self, action: #selector(shareEvent(_:)), forControlEvents: .TouchUpInside)
        
        print("\(#line) | \(eventDetailJSON["EmployeeLike"])")
        
        if eventDetailJSON["EmployeeLike"] {
            likeType = "Unlike"
            headerView.like.setImage(UIImage(named: "wellness_like_filled_blue"), forState: .Normal)
        } else {
            likeType = "Like"
            headerView.like.setImage(UIImage(named: "wellness_like_filled_white"), forState: .Normal)
        }
        headerView.like.addTarget(self, action: #selector(likeEvent(_:)), forControlEvents: .TouchUpInside)
        return headerView
    }
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
    }
    
    func descriptionArrow(sender: UIButton) {
        if sender.tag == 0 {
            descriptionView.descriptionText.alpha = 0
            descriptionView.frame.size.height = 45
            descriptionView.arrowButton.transform = CGAffineTransformMakeRotation(0)
            sender.tag = 1
            addHeightToLayout()
        } else if sender.tag == 1 {
            descriptionView.descriptionText.alpha = 1
            descriptionView.frame.size.height = 250
            descriptionView.arrowButton.transform = CGAffineTransformMakeRotation((CGFloat(M_PI)))
            sender.tag = 0
            addHeightToLayout()
        }
    }
    
    func register(sender: UIButton) {
        eventRegistrationAPI(eventId, button: sender)
    }
    
    func openMaps(recognizer: UIGestureRecognizer) {
        let geocoder = CLGeocoder()
        let str = "Mumbai" // A string of the address info you already have
        print(str)
        geocoder.geocodeAddressString(str) { (placemarksOptional, error) -> Void in
            if let placemarks = placemarksOptional {
                print("placemark| \(placemarks.first)")
                if let location = placemarks.first?.location {
                    let query = "?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
                    let path = "http://maps.apple.com/" + query
                    if let url = NSURL(string: path) {
                        UIApplication.sharedApplication().openURL(url)
                    } else {
                        // Could not construct url. Handle error.
                    }
                } else {
                    // Could not get a location from the geocode request. Handle error.
                }
            } else {
                // Didn't get any placemarks. Handle error.
            }
        }
    }
    
    func eventDetailAPI(id: Int) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            rest.getEventDetail(id, completion: { request in
                if request == 1 {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertController = UIAlertController(title: "No Connection", message:
                            "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                } else {
                    
                    self.eventDetailJSON = request["result"]
                    print("my json: \(self.eventDetailJSON)")
                    
                    if self.eventDetailJSON == [] {
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "No Data", message:
                                "Please try again later", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    
                        self.verticalLayout.addSubview(self.subHeaderView(self.eventDetailJSON["Name"].string!))
                        
                        if self.eventDetailJSON["ImageURL"].string != nil {
                            self.verticalLayout.addSubview(self.eventMapView(self.eventDetailJSON["Address"].string!))
                        }
                        
                        self.verticalLayout.addSubview(self.eventDetailView(
                            self.eventDetailJSON["Name"].string!,
                            location: self.eventDetailJSON["Address"].string!,
                            dateFrom: self.eventDetailJSON["StartDate"].string!,
                            dateTo: self.eventDetailJSON["EndDate"].string!,
                            dateTime: self.eventDetailJSON["FromTime"].string!))
                        
                        if self.eventDetailJSON["IsRegistrationRequired"].bool! {
                            self.verticalLayout.addSubview(self.eventRegistrationView(
                                self.eventDetailJSON["RegistrationStartDate"].string!,
                                dateTo: self.eventDetailJSON["RegistrationEndDate"].string!))
                        }
                        
                        self.verticalLayout.addSubview(self.eventDescriptionView(self.eventDetailJSON["Description"].string!))
                        
                        if self.eventDetailJSON["IsRegistrationRequired"].bool! {
                            self.verticalLayout.addSubview(self.registerButton())
                        }
                        
                        self.verticalLayout.addSubview(self.spaceView())
                        
                        self.addHeightToLayout()
                        
                        LoadingOverlay.shared.hideOverlayView()
                        
                    })
                    
                }
            })
        })
    }
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
    func shareEvent(sender: UIButton) {
        let descriptionText = eventDetailJSON["Description"].stringValue
        let decodedDescription = descriptionText.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        var shareString = "\(eventDetailJSON["Name"])\n\nEvent is all about:\n\(decodedDescription)"
        shareString += "\nEvent date : \(eventDetailJSON["StartDate"])\nEvent time : \n\(eventDetailJSON["FromTime"])"
        displayShareSheet(shareString)
    }
    
    func likeEvent(sender: UIButton) {
        if likeType == "Unlike" {
            self.likeType = "Like"
            sender.setImage(UIImage(named: "wellness_like_filled_white"), forState: .Normal)
            rest.likeEvent(eventId, type: "Unlike", completion: { request in
                print("\(#line) | \(request)")
                if !request["state"] {
                    self.likeType = "Unlike"
                    sender.setImage(UIImage(named: "wellness_like_filled_blue"), forState: .Normal)
                }
            })
        } else if likeType == "Like" {
            self.likeType = "Unlike"
            sender.setImage(UIImage(named: "wellness_like_filled_blue"), forState: .Normal)
            rest.likeEvent(eventId, type: "Like", completion: { request in
                print("\(#line) | \(request)")
                if !request["state"] {
                    self.likeType = "Like"
                    sender.setImage(UIImage(named: "wellness_like_filled_white"), forState: .Normal)
                }
            })
            
        }
    }
    
    func eventRegistrationAPI(id: Int, button: UIButton) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            rest.getEventRegistration(id, completion: { request in
                if request == 1 {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertController = UIAlertController(title: "No Connection", message:
                            "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                } else {
                    if request["state"].bool! {
                        dispatch_async(dispatch_get_main_queue(), {
                            let alertController = UIAlertController(title: "Event Registration Successful", message:
                                "", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                            button.removeFromSuperview()
                        })
                    }
                }
            })
        })
    }

}

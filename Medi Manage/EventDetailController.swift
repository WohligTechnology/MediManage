//
//  EventDetailController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/19/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventDetailController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var eventId: Int!
    var verticalLayout: VerticalLayout!
    var descriptionView: eventDescription!
    var eventDetailJSON: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        
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
        
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        if let dataURL = NSURL(string: imageUrl) {
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
        let registratioView = eventRegistration(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 75))
        registratioView.dateFrom.text = dateFrom
        registratioView.dateTo.text = dateTo
        
        addShadow(registratioView)
        return registratioView
    }
    
    func eventDescriptionView(descriptionText: String) -> UIView {
        descriptionView = eventDescription(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 45))
        addShadow(descriptionView)
        
        descriptionView.descriptionText.text = descriptionText
        descriptionView.descriptionText.alpha = 0
        descriptionView.arrowButton.tag = 1
        descriptionView.arrowButton.addTarget(self, action: #selector(descriptionArrow(_:)), forControlEvents: .TouchUpInside)
        
        return descriptionView
    }
    
    func registerButton() -> UIView {
        let registerButtonView = UIView(frame: CGRect(x: self.view.frame.width - 110, y: 20, width: 100, height: 40))
        registerButtonView.backgroundColor = UIColor(red: 244 / 255, green: 109 / 255, blue: 30 / 255, alpha: 1)
        registerButtonView.layer.cornerRadius = 5.0
        registerButtonView.clipsToBounds = true
        
        let registerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: registerButtonView.frame.width - 20, height: registerButtonView.frame.height))
        registerLabel.text = "REGISTER"
        registerLabel.font = UIFont(name: "Aviner Roman", size: 16)
        registerLabel.textColor = UIColor.whiteColor()
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
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    
                        self.verticalLayout.addSubview(self.subHeaderView(self.eventDetailJSON["Name"].string!))
                        
                        if self.eventDetailJSON["ImageURL"].string != nil {
                            self.verticalLayout.addSubview(self.eventMapView(self.eventDetailJSON["ImageURL"].string!))
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
                        
                    })
                    
                }
            })
        })
    }

}

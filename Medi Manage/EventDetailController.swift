//
//  EventDetailController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/19/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class EventDetailController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var eventId: Int!
    var verticalLayout: VerticalLayout!
    var descriptionView: eventDescription!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        
        scrollView.contentSize.height = self.view.frame.height
        
        verticalLayout = VerticalLayout(width: self.view.frame.width)
        verticalLayout.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        scrollView.addSubview(verticalLayout)
        
        verticalLayout.addSubview(subHeaderView())
        verticalLayout.addSubview(eventMapView())
        verticalLayout.addSubview(eventDetailView())
        verticalLayout.addSubview(eventRegistrationView())
        verticalLayout.addSubview(eventDescriptionView())
        verticalLayout.addSubview(registerButton())
        verticalLayout.addSubview(spaceView())
        
        addHeightToLayout()
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
    
    func eventMapView() -> UIView {
        let mapView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        mapView.backgroundColor = UIColor.blueColor()
        return mapView
    }
    
    func eventDetailView() -> UIView {
        let detailView = eventDetail(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 150))
        detailView.backgroundColor = UIColor.whiteColor()
        addShadow(detailView)
        return detailView
    }
    
    func eventRegistrationView() -> UIView {
        let registratioView = eventRegistration(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 75))
        addShadow(registratioView)
        return registratioView
    }
    
    func eventDescriptionView() -> UIView {
        descriptionView = eventDescription(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 45))
        addShadow(descriptionView)
        
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
    
    func subHeaderView() -> UIView {
        let headerView = eventHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        headerView.title.text = "Mumbai Yoga Fest 2017"
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

}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
        self.view.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        
        scrollView.contentSize.height = self.view.frame.height
        
        verticalLayout = VerticalLayout(width: self.view.frame.width)
        verticalLayout.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        scrollView.addSubview(verticalLayout)
        
//        verticalLayout.addSubview(subHeaderView())
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
        let descriptionView = eventDescription(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 45))
        addShadow(descriptionView)
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
        let headerView = subHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        return headerView
    }
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
    }

}

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
        
        verticalLayout.addSubview(eventMapView())
        verticalLayout.addSubview(eventDetailView())
        
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
        let registratioView = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 150))        
        return registratioView
    }
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
    }

}

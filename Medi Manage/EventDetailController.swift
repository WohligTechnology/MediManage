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
        
        self.view.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        
        scrollView.contentSize.height = self.view.frame.height
        
        verticalLayout = VerticalLayout(width: self.view.frame.width)
        verticalLayout.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
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
        let detailView = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 200))
        detailView.backgroundColor = UIColor.whiteColor()
        detailView.layer.shadowColor = UIColor.blackColor().CGColor
        detailView.layer.shadowOpacity = 0.5
        detailView.layer.shadowOffset = CGSize.zero
        detailView.layer.shadowRadius = 2
        return detailView
    }

}

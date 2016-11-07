//
//  ViewController.swift
//  Medi Manage
//
//  Created by Tushar Sachde on 28/04/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


open class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var blurView: UIVisualEffectView!
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
            
        }
        return Static.instance
    }
    
    open func showOverlay(_ view: UIView) {
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame.size.height = view.frame.height
        blurView.frame.size.width = view.frame.width
        blurView.isUserInteractionEnabled = false
        blurView.addSubview(overlayView)
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(blurView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideOverlayView() {
        activityIndicator.stopAnimating()
        blurView.removeFromSuperview()
    }
}


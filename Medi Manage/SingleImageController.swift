//
//  SingleImageController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/20/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class SingleImageController: UIViewController {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventText: UILabel!
    
    var imageIndex: Int!
    var totalImages: Int!
    var image: UIImage!
    var currentIndex: Int!
    
    var photos: [JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navshow()
        
        currentIndex = imageIndex
        
        eventText.text = "\(currentIndex + 1) / \(totalImages)"
        eventImage.userInteractionEnabled = true
        
        if (photos[currentIndex!]["Path"].string != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                if let dataURL = NSURL(string: self.photos[self.currentIndex!]["Path"].string!) {
                    do {
                        dispatch_async(dispatch_get_main_queue(), {
                            if let data = NSData(contentsOfURL: dataURL) {
                                let image = UIImage(data: data)
                                self.eventImage.image = image
                            }
                        })
                    }
                }
            })
        }
        
        let imageLeftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe(_:)))
        let imageRightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwipe(_:)))
        
        imageLeftSwipe.direction = .Left
        imageRightSwipe.direction = .Right
        
        self.eventImage.addGestureRecognizer(imageLeftSwipe)
        self.eventImage.addGestureRecognizer(imageRightSwipe)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func leftSwipe(sender: AnyObject) {
        currentIndex = Int(currentIndex) + 1
//        print(currentIndex)
        if currentIndex >= totalImages {
            currentIndex = Int(currentIndex) - 1
        } else {
            if (photos[currentIndex!]["Path"].string != nil) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if let dataURL = NSURL(string: self.photos[self.currentIndex!]["Path"].string!) {
                        do {
                            dispatch_async(dispatch_get_main_queue(), {
                                if let data = NSData(contentsOfURL: dataURL) {
                                    let image = UIImage(data: data)
                                    self.eventImage.image = image
                                }
                            })
                        }
                    }
                })
            }
            eventText.text = "\(currentIndex + 1) / \(totalImages)"
        }
    }
    
    func rightSwipe(sender: AnyObject) {
        currentIndex = Int(currentIndex) - 1
//        print(currentIndex)
        if currentIndex < 0 {
            currentIndex = Int(currentIndex) + 1
        } else {
            if (photos[currentIndex!]["Path"].string != nil) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if let dataURL = NSURL(string: self.photos[self.currentIndex!]["Path"].string!) {
                        do {
                            dispatch_async(dispatch_get_main_queue(), {
                                if let data = NSData(contentsOfURL: dataURL) {
                                    let image = UIImage(data: data)
                                    self.eventImage.image = image
                                }
                            })
                        }
                    }
                })
            }
            eventText.text = "\(currentIndex + 1) / \(totalImages)"
        }
    }

}

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
    
    var photos: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navshow()
        
        currentIndex = imageIndex
        
        eventText.text = "\(currentIndex + 1) / \(totalImages)"
        eventImage.image = image
        eventImage.userInteractionEnabled = true
        
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
            self.eventImage.image = UIImage(named: photos[currentIndex!])
            eventText.text = "\(currentIndex + 1) / \(totalImages)"
        }
    }
    
    func rightSwipe(sender: AnyObject) {
        currentIndex = Int(currentIndex) - 1
//        print(currentIndex)
        if currentIndex < 0 {
            currentIndex = Int(currentIndex) + 1
        } else {
            self.eventImage.image = UIImage(named: photos[currentIndex!])
            eventText.text = "\(currentIndex + 1) / \(totalImages)"
        }
    }

}

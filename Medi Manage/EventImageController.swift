//
//  EventImageController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/20/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventImageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var photos: [JSON]!
    var eventId: Int!
    var eventDetailJSON: JSON!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.whiteColor()
        LoadingOverlay.shared.showOverlay(self.view)
        
        navshow()
        
        self.photos = []
        
        eventDetailAPI(eventId)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionCell
        cell.backgroundColor = UIColor.whiteColor()
        
        if (photos[indexPath.item]["Path"].string != nil) {
            dispatch_async(dispatch_get_main_queue(), {
                if let dataURL = NSURL(string: self.photos[indexPath.item]["Path"].stringValue) {
                    do {
                        if let data = NSData(contentsOfURL: dataURL) {
                            let image = UIImage(data: data)
                            cell.eventImage.image = image
                        }
                    }
                }
            })
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
        let singleImageController = storyboard?.instantiateViewControllerWithIdentifier("singleImageController") as! SingleImageController
        singleImageController.image = UIImage(named: photos[indexPath.row]["Path"].stringValue)
        singleImageController.imageIndex = indexPath.item
        singleImageController.totalImages = photos.count
        singleImageController.photos = photos
        self.navigationController?.pushViewController(singleImageController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
        let paddingSpace = sectionInsets.left
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 3
        let heightPerItem = (availableWidth / 3) - 20
        
        return CGSize(width: widthPerItem, height: heightPerItem)
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
                    print("my json: \(self.eventDetailJSON["Pictures"])")
                    
                    if self.eventDetailJSON["Pictures"] == [] || self.eventDetailJSON["Pictures"] == nil {
                        dispatch_async(dispatch_get_main_queue(), {
                            LoadingOverlay.shared.hideOverlayView()
                            let nodataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
                            nodataLabel.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
                            nodataLabel.text = "No Images"
                            nodataLabel.textAlignment = .Center
                            self.view.addSubview(nodataLabel)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            LoadingOverlay.shared.hideOverlayView()
                            self.photos = self.eventDetailJSON["Pictures"].arrayValue
                            self.collectionView.reloadData()
                        })
                    }
                }
            })
        })
    }

}

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    
}
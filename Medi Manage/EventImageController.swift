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
    
    var photos: [String]!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        photos = ["tutorial", "call_icon", "tutorial", "tutorial", "daughter_icon", "tutorial", "tutorial", "tutorial",
                    "tutorial", "father_icon", "tutorial", "tutorial", "call_icon2", "tutorial", "tutorial", "tutorial"]
        
        navshow()
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
        cell.eventImage.image = UIImage(named: photos[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let singleImageController = storyboard?.instantiateViewControllerWithIdentifier("singleImageController") as! SingleImageController
        singleImageController.image = UIImage(named: photos[indexPath.row])
        singleImageController.imageIndex = indexPath.row
        singleImageController.totalImages = 20
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

}

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    
}
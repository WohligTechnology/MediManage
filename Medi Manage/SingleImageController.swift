//
//  SingleImageController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/20/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class SingleImageController: UIViewController {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventText: UILabel!
    
    var imageIndex: Int!
    var totalImages: Int!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navshow()
        
        eventText.text = "\(imageIndex + 1) / \(totalImages)"
        eventImage.image = image
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//
//  FeedbackController.swift
//  mpowerplus
//
//  Created by Wohlig Technology on 1/24/17.
//  Copyright © 2017 Wohlig Technology. All rights reserved.
//

import UIKit

class FeedbackController: UIViewController {
    
    @IBOutlet weak var oneTextField: UITextField!
    @IBOutlet var twoCheckboxes: [UIButton]!
    @IBOutlet var threeRadios: [UIButton]!
    @IBOutlet var fourRadios: [UIButton]!
    
    var threeValues = ["1", "2", "3", "4"]
    var fourValues = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        
//        oneTextField.layer.borderWidth = 1
//        oneTextField.layer.borderColor = UIColor.blackColor().CGColor
        
        for button in twoCheckboxes {
            button.tag = 0
            button.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
            button.addTarget(self, action: #selector(checkboxClick(_:)), forControlEvents: .TouchUpInside)
        }
        
        for radio in threeRadios {
            radio.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
            for i in threeValues {
                radio.setTitle(i, forState: .Application)
            }
            radio.addTarget(self, action: #selector(threeRadioClick(_:)), forControlEvents: .TouchUpInside)
        }
        
        for radio in fourRadios {
            radio.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
            for i in fourValues {
                radio.setTitle(i, forState: .Application)
            }
            radio.addTarget(self, action: #selector(fourRadioClick(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkboxClick (sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
            sender.tag = 1
        } else if sender.tag == 1 {
            sender.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
            sender.tag = 0
        }
    }
    
    var index: String!
    
    func threeRadioClick (sender: UIButton) {
        index = sender.titleForState(.Application)
        for radio in threeRadios {
            radio.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
        }
        sender.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
    }
    
    func fourRadioClick (sender: UIButton) {
        index = sender.titleForState(.Application)
        for radio in fourRadios {
            radio.setImage(UIImage(named: "checkbox_untick"), forState: .Normal)
        }
        sender.setImage(UIImage(named: "checkbox_tick"), forState: .Normal)
    }

}

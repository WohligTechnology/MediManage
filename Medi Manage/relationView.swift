

import UIKit
import SwiftyJSON

@IBDesignable class relationView: UIView {
    
    @IBOutlet weak var memberLabel: UILabel!
    var data : JSON = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "relationView", bundle: bundle)
        let helpDesk = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        helpDesk.frame = bounds
        helpDesk.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(helpDesk)
    }
        
}

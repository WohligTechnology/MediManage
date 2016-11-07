

import UIKit
import SwiftyJSON

class relationView: UIView {
    
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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "relationView", bundle: bundle)
        let helpDesk = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        helpDesk.frame = bounds
        helpDesk.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(helpDesk)
    }
        
}

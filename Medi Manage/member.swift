
import UIKit
import Alamofire
import SwiftyJSON

class member: UIView {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var middleName: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var relation: UILabel!
    @IBOutlet weak var ecardOutlate: UIButton!
    var ecarddwld = ""
    var isAvailable : Bool = false
    
    var webView: UIWebView! = UIWebView()
    
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
        let nib = UINib(nibName: "member", bundle: bundle)
        let sortnewview = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(sortnewview)
        
        webView = UIWebView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        webView.hidden = false
    }
    
    @IBAction func downloadEcardButton(sender: AnyObject) {
        print("in download ECard")
        print(lastname)
        print(ecarddwld)
        rest.DownloadECard(ecarddwld,completion: {(json:JSON) -> ()in
            if json["state"] {
                UIApplication.sharedApplication().openURL(NSURL(string: json["result"].stringValue)!)
            }
        })
    }
}

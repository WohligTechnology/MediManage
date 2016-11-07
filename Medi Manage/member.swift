
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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "member", bundle: bundle)
        let sortnewview = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        sortnewview.frame = bounds
        sortnewview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(sortnewview)
        
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        webView.isHidden = false
    }
    
    @IBAction func downloadEcardButton(_ sender: AnyObject) {
        print("in download ECard")
        print(ecarddwld)
        if ecarddwld == "0" {
            Popups.SharedInstance.ShowPopup("Members", message: "Don't have any id.")
        }else{
        rest.DownloadECard(ecarddwld,completion: {(json:JSON) -> ()in
            dispatch_get_main_queue().sync(DispatchQueue.mainexecute: {
                print(json)
            if json["state"] {
                if json["result"] != ""{
                let pdfURL = NSURL(string: (json["result"].stringValue).stringByAddingPercentEscapesUsingEncoding(String.Encoding.utf8)!)!
                UIApplication.sharedApplication().openURL(pdfURL)
                }
            }
            })
        })
        }
    }
}


import UIKit
import Alamofire

class member: UIView {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var middleName: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var relation: UILabel!
    
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
        //The URL to Save
//        let pdfURL = NSURL(string: "http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf")
////        //Create a URL request
////        let urlRequest = NSURLRequest(URL: pdfURL!)
////        //get the data
////        let theData = NSURLConnection.sendSynchronousRequest(urlRequest)
////        //Get the local docs directory and append your local filename.
////        var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last
////        docURL = docURL?.URLByAppendingPathComponent("myFileName.pdf")
////        //Lastly, write your file to the disk.
////        theData.writeToURL(docURL!, atomically: true)
//        let writePath = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf")
//        let url: NSURL = NSURL(string: "http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf")!
//        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
//        webView.hidden = true
//        webView!.loadRequest(urlRequest)
        
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.renderInContext(UIGraphicsGetCurrentContext())
//        let image = UIGraphicsGetPDFContextBounds()
//        UIGraphicsEndPDFContext()
//        
//        // Save image to Camera Roll
//        UIPdf
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        
//        return UIImageView(image: image)
        
        print("download pdf")
        
        var docController: UIDocumentInteractionController?
        do {
        let path = NSBundle.mainBundle().pathForResource("http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521", ofType: "pdf")
            //let targetURL: NSURL!
            print("path \(path)")
            do {
                let targetURL = NSURL.fileURLWithPath(path!)
                docController = UIDocumentInteractionController(URL: targetURL)
                let url = NSURL(string:"http://testcorp.medimanage.com/api/Files/EcardsDownloads/TestMastek1_25072016124521.pdf:");
                print("yaha print")
                if UIApplication.sharedApplication().canOpenURL(url!) {
                    docController!.presentOpenInMenuFromRect(CGRectZero, inView: self, animated: true)
                    print("iBooks is installed")
                } else {
                    print("iBooks is not installed")
                }
            }
        }
        
        print("downloaded")
    }
}

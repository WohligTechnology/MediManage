//
//  HelpDeskFAQController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 21/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

var expandedHeight: CGFloat!

var gHelpDeskFAQController: UIViewController!

class HelpDeskFAQController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var queans : JSON = ""
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var helpFaqTable: UITableView!
    var jsonCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gHelpDeskFAQController = self
        navshow()
        self.helpFaqTable.delegate = self
        //        LoadingOverlay.shared.showOverlay(self.view)
        selectedViewController = false
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        performSelector(inBackground: #selector(HelpDeskFAQController.loadnow), with: nil)
        //self.loadnow()
        //helpFaqTable.reloadData()
    }
    
    override func performSelector(inBackground aSelector: Selector, with arg: Any?) {
        loadnow()
        helpFaqTable.reloadData()
    }
    
    func loadnow() {
        let mainsubHeader = subHeader(frame: CGRect(x: 0, y: 60, width: width, height: 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_four")
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.view.addSubview(mainsubHeader)
        
        rest.FaqDetails({(json:JSON) -> () in
            DispatchQueue.main.asynchronously(DispatchQueue.mainexecute: {
            //dispatch_async(dispatch_get_global_queue(0,0), {
                print(json)
                if json == 401 {
                    gHelpDeskFAQController.redirectToHome()
                } else{
                    self.queans = json["result"]["list"]
                    self.jsonCount = self.queans.count
                    print("\(#line) quens data: \(self.queans)")
                //                LoadingOverlay.shared.hideOverlayView()
                }
            })
            DispatchQueue.main.asynchronously(DispatchQueue.mainexecute: {
                print("1")
                self.helpFaqTable.rowHeight = UITableViewAutomaticDimension
                print("2")
                expandedHeight = self.helpFaqTable.rowHeight
                print("3")
                self.helpFaqTable.reloadData()
                print("4")
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedViewController = false
//        self.loadnow()
        self.reloadInputViews()
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.queans.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! quecell).watchFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! quecell).ignoreFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if indexPath.row == 0 {
        //            return InsuredMemberCell.expandedHeight
        //        }
        if indexPath == selectedIndexPath {
            return quecell.expandedHeight
        } else {
            return quecell.defaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! quecell
        
        cell.selectionStyle = .none
        let ques = (self.queans[indexPath.item]["Question"].stringValue.stringByRemovingPercentEncoding)!
        do {
            let str = try NSMutableAttributedString(data: ques.dataUsingEncoding(String.Encoding.unicode, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            str.addAttributes([NSForegroundColorAttributeName: UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1), NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!], range: NSRange(location: 0, length: str.length))
            cell.questionlbl.attributedText = str
            
        } catch {
            print(error)
        }
        
        let ans = (self.queans[indexPath.item]["Answer"].stringValue.stringByRemovingPercentEncoding)
        do {
            let str = try NSMutableAttributedString(data: ans!.dataUsingEncoding(String.Encoding.unicode, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            str.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "Lato-Regular", size: 12)!], range: NSRange(location: 0, length: str.length))
            //cell.answerlbl.attributedText = str
            //cell.answerlbl.hidden = true
            cell.webView.loadHTMLString(String(str), baseURL: nil)
        } catch {
            print(error)
        }
        
//        tableView.reloadData();
        //tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        return cell
    }
}

class quecell: UITableViewCell {
    
    @IBOutlet weak var questionlbl: UILabel!
    @IBOutlet weak var answerlbl: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var triangle: UIImageView!
    
    class var expandedHeight: CGFloat { get { return 200} }
    class var defaultHeight: CGFloat { get { return 70 } }
    
    func checkHeight() {
        answerlbl.isHidden = (frame.size.height < quecell.expandedHeight)
//        if quecell.expandedHeight <= frame.size.height {
//            triangle.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
//        }
    }
    
    func watchFrameChanges() {
        //addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        //removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
}

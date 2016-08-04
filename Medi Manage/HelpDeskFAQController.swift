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
    var selectedIndexPath: NSIndexPath?
    
    @IBOutlet weak var helpFaqTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navshow()
        //        LoadingOverlay.shared.showOverlay(self.view)
        selectedViewController = false
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    func loadnow() {
        let mainsubHeader = subHeader(frame: CGRectMake(0, 60, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_four")
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.view.addSubview(mainsubHeader)
        
        
        rest.FaqDetails({(json:JSON) -> ()in
            if json == 401 {
                gHelpDeskFAQController.redirectToHome()
            }else{
                self.queans = json["result"]["list"]
                self.helpFaqTable.reloadData()
                //                LoadingOverlay.shared.hideOverlayView()
            }
        })
        gHelpDeskFAQController = self
        helpFaqTable.rowHeight = UITableViewAutomaticDimension
        expandedHeight = helpFaqTable.rowHeight
        helpFaqTable.reloadData();
        
    }
    
    override func viewWillAppear(animated: Bool) {
        selectedViewController = false
        self.loadnow()
        self.reloadInputViews()
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.queans.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! quecell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! quecell).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        if indexPath.row == 0 {
        //            return InsuredMemberCell.expandedHeight
        //        }
        if indexPath == selectedIndexPath {
            return quecell.expandedHeight
        } else {
            return quecell.defaultHeight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! quecell
        
        cell.selectionStyle = .None
        let ques = (self.queans[indexPath.item]["Question"].stringValue.stringByRemovingPercentEncoding)!
        do {
            let str = try NSMutableAttributedString(data: ques.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            str.addAttributes([NSForegroundColorAttributeName: UIColor(red: 244/255, green: 121/255, blue: 32/255, alpha: 1), NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!], range: NSRange(location: 0, length: str.length))
            cell.questionlbl.attributedText = str
            
        } catch {
            print(error)
        }
        
        let ans = (self.queans[indexPath.item]["Answer"].stringValue.stringByRemovingPercentEncoding)
        do {
            let str = try NSMutableAttributedString(data: ans!.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            str.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "Lato-Regular", size: 12)!], range: NSRange(location: 0, length: str.length))
            cell.answerlbl.attributedText = str
            cell.answerlbl.hidden = true
        } catch {
            print(error)
        }
        
        return cell
    }
}

class quecell: UITableViewCell {
    
    @IBOutlet weak var questionlbl: UILabel!
    @IBOutlet weak var answerlbl: UILabel!
    
    class var expandedHeight: CGFloat { get { return 200} }
    class var defaultHeight: CGFloat { get { return 90 } }
    
    func checkHeight() {
        answerlbl.hidden = (frame.size.height < quecell.expandedHeight)
    }
    
    func watchFrameChanges() {
        //addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        //removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
}

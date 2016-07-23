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
        
        let navigationLogo = UIImage(named: "logo_small")
        let navigationImageView = UIImageView(image: navigationLogo)
        self.navigationItem.titleView = navigationImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let statusBar = UIView(frame: CGRectMake(0, 0, width, 20))
        statusBar.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        self.view.addSubview(statusBar)
        
//        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
//        self.view.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "footer_four")
        mainsubHeader.subHeaderTitle.text = "HELP DESK"
        self.view.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        
//        dummyButton.layer.zPosition = 10000
        print(categoryId)
        rest.FaqDetails({(json:JSON) -> ()in
//            print(json)
            self.queans = json["result"]["list"]
            print(self.queans.count)
            self.helpFaqTable.reloadData()
            
        })
        gHelpDeskFAQController = self
        helpFaqTable.rowHeight = UITableViewAutomaticDimension
        expandedHeight = helpFaqTable.rowHeight
        // Do any additional setup after loading the view.
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
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
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

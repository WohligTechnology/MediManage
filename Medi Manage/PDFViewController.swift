//
//  PDFViewController.swift
//  MediManage
//
//  Created by Jagruti  on 12/07/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

    @IBOutlet weak var pdflbl: UILabel!
    @IBOutlet weak var webViewpdf: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pdfname)
        let pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(pdfname, ofType:"pdf")!)
        let request = NSURLRequest(URL: pdfLoc);
        self.webViewpdf.loadRequest(request);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

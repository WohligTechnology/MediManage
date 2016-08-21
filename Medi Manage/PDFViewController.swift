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
        print("demo demo demo")
        navshow()
        let pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(pdfname, ofType:"pdf")!)
        let request = NSURLRequest(URL: pdfLoc);
        self.webViewpdf.loadRequest(request);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

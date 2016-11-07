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
        if pdfname == ""{
            self.pdflbl.isHidden = false
            self.webViewpdf.isHidden = true
        }else{
            self.pdflbl.isHidden = true
            self.webViewpdf.isHidden = false
        let pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: pdfname, ofType:"pdf")!)
        let request = URLRequest(url: pdfLoc);
        self.webViewpdf.loadRequest(request);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

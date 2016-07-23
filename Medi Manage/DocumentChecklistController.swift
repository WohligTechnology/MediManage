//
//  DocumentChecklistController.swift
//  Medi Manage
//
//  Created by Harsh Thakkar on 18/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

var gDocumentChecklistController: UIViewController!

class DocumentChecklistController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let image = ["claim_three", "claim_three", "claim_three", "claim_three", "claim_three", "claim_three", "claim_three", "claim_three", "claim_three", "claim_three"]
    let pdfs = ["CLAIM FORM SIGNED BY EMPLOYEE",
                     "Discharge Summary",
                     "Doctor's Prescription",
                     "Main Hospital Bill",
                     "Laboratory Payment Receipt",
                     "Laboratory Report",
                     "X-Ray Report",
                     "Medicine Bill",
                     "PHOTO ID PROOF AND ADDRESS PROOF OF PATIENT",
                     "Pre Numbered Cash Paid Receipt"]
    let titleMain = ["CLAIM FORM SIGNED BY EMPLOYEE",
                     "DISCHARGE CARD",
                     "LETTER OF 1ST CONSULTATION AND ADVICE FOR HOSPITALIZATION",
                     "PROPER HOSPITAL BILLS WITH RECEIPTS DULY STAMPED & SIGNED",
                     "MEDICINE BILLS WITH DOCTOR’S PRESCRIPTIONS FOR THE SAME",
                     "INVESTIGATION REPORTS, BILL RECEIPTS &ADVICE LETTER FOR ALL THE TESTS PERFORMED",
                     "CONSULTATION RECEIPTS",
                     "CERTIFIED INDOOR CASE PAPER (ICP)",
                     "PHOTO ID PROOF AND ADDRESS PROOF OF PATIENT",
                     "CANCELLED CHEQUE FOR CLAIM DISBURSEMENT:"]
    let desc = ["(All details must be filled in & should be signed by The EMPLOYEE only)",
                "(Contains Date of Admission & discharge, patient’s condition while getting hospitalized,brief diagnosis & treatment administered at hospital& doctors advice on discharge)",
                "(This is the letter of your doctor advise you to get hospitalized for medical treatment of disease ora Surgical Procedure. It should be on the doctor letterhead along with the date of Consultation)",
                "(This is most important document & in absence of it, no payment can be made. The bill should be detailed with the Registration No. of the hospital. The receipt for the payments made should be Pre-numbered and preferably Pre-printed)",
                "(Each medicine bill must have date & patient’s name along with Doctor Prescription)",
                "(For all the tests conducted, the same MUST be advised by the doctor. A receipt of payment should be produced & the reportshould be submitted. Please do not send any X-Ray films. Only report by competent doctor is good enough for claim processing)",
                "(This is the proof of payment made to doctor for consultations. Please insist on consultation paper with date & receipt of Consultation charges paid every time you visit)",
                "(The treatment details of the patient maintained by the Hospital for the records)",
                "(Reimbursement claim amount which is above Rs. 1 lakh, please submit Photo ID proof & address proof of patient)",
                "(Cancelled cheque)"]
    
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
        
        let mainheader = header(frame: CGRectMake(0, 20, width, 50))
        self.view.addSubview(mainheader)
        
        let mainsubHeader = subHeader(frame: CGRectMake(0, 70, width, 50))
        mainsubHeader.subHeaderIcon.image = UIImage(named: "document_checklist")
        mainsubHeader.subHeaderTitle.text = "DOCUMENT CHECKLIST"
        self.view.addSubview(mainsubHeader)
        
        let mainfooter = footer(frame: CGRectMake(0, height - 55, width, 55))
        mainfooter.layer.zPosition = 1000
        self.view.addSubview(mainfooter)
        
        dcDesc.font = UIFont(name: "Lato-Light", size: 10.0)
//        self.dcDesc.estimate
        self.documentTable.estimatedRowHeight = 80
        self.documentTable.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desc.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! documentChecklistUIViewCell
        cell.dcTitle.text = titleMain[indexPath.item]
        cell.dcDesc.text = desc[indexPath.item]
        cell.dcImage.image = UIImage(named: image[indexPath.item])
        cell.selectionStyle = .None
        
        tableView.scrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        
        if(indexPath.item % 2 != 0) {
            cell.dcView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("viewPDF", sender: self)

    }
    
    @IBOutlet weak var dcDesc: UILabel!
    
    @IBOutlet weak var documentTable: UITableView!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "viewPDF"){
            let indexPaths = self.documentTable!.indexPathForSelectedRow
            pdfname = pdfs[(indexPaths?.item)!]
            let vc = segue.destinationViewController as! PDFViewController
            vc.title = self.pdfs[(indexPaths?.row)!]
            
        }
    }
    

}

// MARK: - TableView Cell Class

class documentChecklistUIViewCell: UITableViewCell {
    @IBOutlet weak var dcView: UIView!
    @IBOutlet weak var dcImage: UIImageView!
    @IBOutlet weak var dcTitle: UILabel!
    @IBOutlet weak var dcDesc: UILabel!
}
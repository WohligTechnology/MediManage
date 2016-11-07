//
//  EmployeeGroupDTO.swift
//  MediManage
//
//  Created by Wohlig Technology on 6/23/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

public enum Gender: Int {
    case male = 1, female,others
}


open class EmployeeDTO : NSObject
{
    open var ID : Int { get{ return self.ID }  set{  } }
    open var FirstName : String { get{ return self.FirstName} set{} }
    open var MiddleName :String { get{return self.MiddleName} set{} }
    open var LastName : String { get{ return self.LastName } set{} }
    open var DateOfBirth : Date { get{ return self.DateOfBirth } set{} }
    open var dobDay : Int { get{ return self.dobDay} set{} }
    open var dobMonth : Int { get{return self.dobMonth } set{} }
    open var dobYear : Int { get{ return self.dobYear} set{} }
    open var dorDay : Int { get{return self.dorDay } set{} }
    open var dorMonth : Int { get{ return self.dorMonth } set{} }
    open var dorYear : Int { get{ return self.dorYear } set{} }
    open var Exist : String { get{return self.Exist } set{} }
    
    open var Status: String  {get{return self.Status } set{}}
    
    
   // public var AddedAt : MemberAddedAt{get{ return self.AddedAt } set{} }
    open var Gender : Int?
    open var RelationType : String { get{return self.RelationType } set{} }
    open var DateOfRelation : String { get{ return self.DateOfRelation } set{} }
    open var SystemIdentifier : String { get{return self.SystemIdentifier} set{} }
    open var UHID : String { get{ return self.UHID } set{} }
    
    open var Amount : Double { get{ return self.Amount } set{} }
    open var Tax : Double { get{ return self.Tax } set{} }
    open var NetAmount : Double { get{return self.NetAmount } set{} }
    
    open var TopupAmount :Double{ get{ return self.TopupAmount } set{} }
    open var TopupTax : Double { get{ return self.TopupTax } set{} }
    open var TopupNetAmount : Double { get{ return self.TopupNetAmount} set{} }
    
}

open class MembersDTO
{
    open var ID : Int = 0
    open var FirstName : String = ""
    open var MiddleName : String = ""
    open var LastName  :String = ""
    open var DateOfBirth =  Date()
    
    open var dobDay : Int = 0
    open var dobMonth : Int = 0
    open var dobYear : Int = 0
    open var dorDay : Int = 0
    open var dorMonth : Int = 0
    open var dorYear : Int = 0
    open var Exist : String = ""
    open var InsuredStatus :Int = 0
    open var MemberAddedAt : Int = 0
    open var Gender : Int = 0
    open var RelationType : String = ""
    open var DateOfRelation : String?
    open var SystemIdentifier : String = ""
    open var UHID : String = ""
    
    open var Amount : Double = 0
    open var Tax : Double = 0
    open var NetAmount : Double = 0
    
    open var TopupAmount : Double = 0
    open var TopupTax : Double = 0
    open var TopupNetAmount : Double = 0
    
}

open class SendQueryDTO
{
    open var To : String = ""
    open var Subject : String = ""
    open var Body : String = ""
}

 


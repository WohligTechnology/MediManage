//
//  EmployeeGroupDTO.swift
//  MediManage
//
//  Created by Wohlig Technology on 6/23/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import UIKit

 enum Gender : Int {
  case Male = 1
    case  Female = 2
    case  Others = 3


}




public class EmployeeDTO : NSObject
{
    public var ID : Int { get{ return self.ID }  set{  } }
    public var FirstName : String { get{ return self.FirstName} set{} }
    public var MiddleName :String { get{return self.MiddleName} set{} }
    public var LastName : String { get{ return self.LastName } set{} }
    public var DateOfBirth : NSDate { get{ return self.DateOfBirth } set{} }
    public var dobDay : Int { get{ return self.dobDay} set{} }
    public var dobMonth : Int { get{return self.dobMonth } set{} }
    public var dobYear : Int { get{ return self.dobYear} set{} }
    public var dorDay : Int { get{return self.dorDay } set{} }
    public var dorMonth : Int { get{ return self.dorMonth } set{} }
    public var dorYear : Int { get{ return self.dorYear } set{} }
    public var Exist : String { get{return self.Exist } set{} }
    
    public var Status: String  {get{return self.Status } set{}}
    
    
   // public var AddedAt : MemberAddedAt{get{ return self.AddedAt } set{} }
    public var Gender : Int?
    public var RelationType : String { get{return self.RelationType } set{} }
    public var DateOfRelation : NSDate { get{ return self.DateOfRelation } set{} }
    public var SystemIdentifier : String { get{return self.SystemIdentifier} set{} }
    public var UHID : String { get{ return self.UHID } set{} }
    
    public var Amount : Double { get{ return self.Amount } set{} }
    public var Tax : Double { get{ return self.Tax } set{} }
    public var NetAmount : Double { get{return self.NetAmount } set{} }
    
    public var TopupAmount :Double{ get{ return self.TopupAmount } set{} }
    public var TopupTax : Double { get{ return self.TopupTax } set{} }
    public var TopupNetAmount : Double { get{ return self.TopupNetAmount} set{} }
    
}

public class MembersDTO : NSObject
{
    public var ID : Int?
    public var FirstName : String?
    public var MiddleName : String?
    public var LastName  :String?
    public var DateOfBirth : NSDate?
    
    public var dobDay : Int?
    public var dobMonth : Int?
    public var dobYear : Int?
    public var dorDay : Int?
    public var dorMonth : Int?
    public var dorYear : Int?
    public var Exist : String?
   // public var InsuredStatus :Status?  
   //  public MemberAddedAt AddedAt { get; set; }
    public var Gender : Gender?
    public var RelationType : String?
    public var DateOfRelation : String?
    public var SystemIdentifier : String?
    public var UHID : String?
    
    public var Amount : Double?
    public var Tax : Double?
    public var NetAmount : Double?
    
    public var TopupAmount : Double?
    public var TopupTax : Double?
    public var TopupNetAmount : Double?
    
}

 


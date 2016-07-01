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
    case Male = 1, Female,Others
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

public class MembersDTO
{
    public var ID : Int = 0
    public var FirstName : String = ""
    public var MiddleName : String = ""
    public var LastName  :String = ""
    public var DateOfBirth =  NSDate()
    
    public var dobDay : Int = 0
    public var dobMonth : Int = 0
    public var dobYear : Int = 0
    public var dorDay : Int = 0
    public var dorMonth : Int = 0
    public var dorYear : Int = 0
    public var Exist : String = ""
    public var InsuredStatus :Int = 0
    public var MemberAddedAt : Int = 0
    public var Gender : Int = 0
    public var RelationType : String = ""
    public var DateOfRelation : String = ""
    public var SystemIdentifier : String = ""
    public var UHID : String = ""
    
    public var Amount : Double = 0
    public var Tax : Double = 0
    public var NetAmount : Double = 0
    
    public var TopupAmount : Double = 0
    public var TopupTax : Double = 0
    public var TopupNetAmount : Double = 0
    
}

 


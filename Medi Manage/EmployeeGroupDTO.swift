//
//  EmployeeGroupDTO.swift
//  MediManage
//
//  Created by Wohlig Technology on 6/23/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation


public class EmployeeDTO
{
    public var EmployeeNumber :String { get{} set {} }
    
    //public IList<EmployeeGroupDTO> Groups { get; set; }
    public var PaymentMode : Int { get{} set{} }
    public var HasECards : Bool { get{} set{} }
    public var ECardURL : String { get{} set{} }
    public var IsECardAvailable :String { get{} set{} }
    public var TPAEnrollmentNo : String { get{} set{} }
    public var EmployeeGender : Gender { get{} set{} }
    public var PlanMembers = [PlanMembers]()
    public var MinTopupSI : String { get{} set{} }
    public var MinTopupPremium : Double { get{} set{} }
    public var ClientId : u_long { get{} set{} }
    public var ClientName : String { get{} set{} }
    public var PlanComposition : String { get{} set{} }
    public var AssignedPlanID : u_long { get{} set{} }
    public var CustomMessages : String { get{} set{} }
    public var IsInEnrollmentPeriod : Bool { get{} set{} }
    public var EnrollmentStartDate : NSDate { get{} set{} }
    public var EnrollmentEndDate : NSDate { get{} set{} }
    public var IsEnrollmentConfirmed : Bool { get{} set{} }
    public var PaidAmount : Double { get{} set{} }
    public var HasTopupCoverage : Bool { get{} set{} }
    public var MaritalStatus : MaritalStatus { get{} set{}}
    public var EnableCrossParentalPolicy : Bool { get{} set{} }
    public var CrossParentalMessage : String { get{} set{} }
    
    public func EmployeeDTO()
    {
    var Groups = [EmployeeGroupDTO]()
    var PlanMembers = [PlanMembers]()
    }
    
}

public class PlanMembers
{
    public var Allowed : Int { get{} set{} }
    public var Member : String { get{} set{} }
}

public class EmployeeGroupDTO
{
    public var GroupID : u_long { get{} set{} }
    public var GroupComposition : String { get{} set{} }
    public var PremiumType : GroupPremiumType   { get{} set{} }
    public var TopupPremiumType : GroupPremiumType  { get{} set{} }
    public var GroupType : PolicyPlanGroupType { get{} set{} }
    public var SelectedSumInsured : u_long { get{} set{} }
    public var SelectedTopup : u_long { get{} set{} }
    public var Amount : Double { get{} set{} }
    public var Tax : Double { get{} set{} }
    public var NetAmount : Double { get{} set{} }
    
    public var TopupAmount : Double { get{} set{} }
    public var TopupTax : Double { get{} set{} }
    public var TopupNetAmount : Double { get{} set{} }
    
    public var SelSI : String { get {} set{} }
    public var SelTopup : String { get{} set{} }
    public var TotalSI : String { get{} set{} }
    
    public var SelectedSumInsuredValue : Double { get{} set{} }
    public var SelectedTopupValue : Double { get{} set{} }
    
    public IList<SumInsuredDTO> SumInsuredList { get{}, set{} }
    public IList<MembersDTO> Members { get{} set{} }
    
    public func EmployeeGroupDTO()
    {
    SumInsuredList = new List<SumInsuredDTO>();
    Members = new List<MembersDTO>();
    }
    
}


public class SumInsuredDTO
{
    public var PolicySI : u_long = { get{} set{} }
    public var SumInsured : String { get{} set{} }
    public var SumInsuredValue  :Double { get{} set{} }
    public IList<TopupSumInsuredDTO> TopupList { get{} set{} }
    
}

public class TopupSumInsuredDTO
{
    public var PolicyTSI : Long { get; set; }
    public var SumInsured :String { get; set; }
    public var SumInsuredValue : Double { get; set; }
}

public class MembersDTO
{
    public var ID : u_long { get{} set{} }
    public var FirstName : String { get{} set{} }
    public var MiddleName :String { get{} set{} }
    public var LastName : String { get{} set{} }
    public var DateOfBirth : NSDate { get{} set{} }
    public var dobDay : Int { get{} set{} }
    public var dobMonth : Int { get{} set{} }
    public var dobYear : Int { get{} set{} }
    public var dorDay : Int { get{} set{} }
    public var dorMonth : Int { get{} set{} }
    public var dorYear : Int { get{} set{} }
    public var Exist : String { get{} set{} }
    public var Status: InsuredStatus  { get{} set{} }
    public var AddedAt : MemberAddedAt  { get{} set{} }
    public var Gender : Gender  { get{} set{} }
    public var RelationType : String { get{} set{} }
    public var DateOfRelation : NSDate { get{} set{} }
    public var SystemIdentifier : String { get{} set{} }
    public var UHID : String { get{} set{} }
    
    public var Amount : Double { get{} set{} }
    public var Tax : Double { get{} set{} }
    public var NetAmount : Double { get{} set{} }
    
    public var TopupAmount :Double{ get{} set{} }
    public var TopupTax : Double { get{} set{} }
    public var TopupNetAmount : Double { get{} set{} }
    
}

public class UpdateMembersParamter
{
    public var EmployeeID : u_long  { get; set; }
    //public IList<MembersDTO> Members { get; set; }
    
    public UpdateMembersParamter()
    {
    Members = new List<MembersDTO>();
    }
}

}

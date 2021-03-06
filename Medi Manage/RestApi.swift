//
//  RestApi.swift
//  MediManage
//9
//  Created by Jagruti Patil on 30/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import CoreData
import SystemConfiguration
import Alamofire
import SwiftHTTP



let adminUrl = "https://corporate.medimanage.com/api/";
//let adminUrl = "http://testcorp.medimanage.com/api/"
let apiURL = adminUrl + "v1/";
let defaultToken = NSUserDefaults.standardUserDefaults()

public class RestApi {
        public func findEmployee(empno:String, dob:String, completion:((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["EmpNo":empno, "DOB":dob]
        do {
            let opt = try HTTP.POST(apiURL + "Users/FindEmployee", parameters: params, requestSerializer: JSONParameterSerializer(), headers:["header":"application/json"])
            opt.start { response in
                if let _ = response.error {
                    completion(json);
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    public func login(username:String, password:String, completion:((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["grant_type": "password","username":username, "password":password]
            let header = ["Content-Type":"application/x-www-form-urlencoded"]
        
        do {
            let opt = try HTTP.POST(adminUrl + "token", parameters: params, requestSerializer: JSONParameterSerializer(), headers:header)
       // opt.security = HTTPSecurity(certs: [HTTPSSLCe(data: data)], usePublicKeys: true)
         
            opt.start { response in
            
                print(response.error)
                if let _ = response.error {
                    completion(json);
                   
//                    jagruti@wohlig.com
                }
                else
                {
                    json  = JSON(data: response.data)
                    let defaults = NSUserDefaults.standardUserDefaults()
                    print(json["access_token"])
                    defaults.setValue(String(json["access_token"]), forKey: defaultsKeys.token)
                   // setBool(true, forKey: "loadingOAuthToken")
                    completion(json);
                    
                }
            }
        } catch _ {
            completion(json);
          
    
        }
    }
    
  public func loginAlaomFire(username:String, password:String, completion:((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["grant_type": "password","username":username, "password":password]
        let header = ["Content-Type":"application/x-www-form-urlencoded"]
        
    Manager.request(.POST, adminUrl+"token" ,parameters: params, headers: header)
            .responseJSON { response in
                debugPrint(response)
                json = JSON(data: response.data!)
                   completion(json)
                    
                }
    }

    private var Manager : Alamofire.Manager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
           "testcorp.medimanage.com" : .DisableEvaluation
        ]
        // Create custom manager
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        let man = Alamofire.Manager(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    
//    public func findEmployeeProfile(SUBURL : String,completion:((JSON) -> Void))
//    {
//        var json = JSON(1)
//        let token = defaultToken.stringForKey("access_token")
//        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]       
//        Manager.request(.GET, apiURL+SUBURL ,parameters: nil, headers: isLoginheader)
//            .responseJSON { response in
////                print(response)
//               // debugPrint(response)
//                json = JSON(data: response.data!)
//                //print(json["access_token"])
//                completion(json)
//               // print(json)
//                
//        }}
    
    public func findEmployeeProfile(SUBURL : String,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        var isLoginheader = [String:String]()
        let token = defaultToken.stringForKey("access_token")
        if token != nil {
             isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        }
        print(token)
        
        do {
            let opt = try HTTP.GET(apiURL+SUBURL , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    
    public func GetProfile(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Users/Profile" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    
    public func UpdateProfile(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        print("data to params")
        print(data)
        let params = ["Email": data["Email"].stringValue,"MobileNo":data["MobileNo"].stringValue, "EmployeeID":data["EmployeeID"].stringValue, "EmployeeNumber":data["EmployeeNumber"].stringValue, "Password":data["Password"].stringValue, "MaritalStatus": data["MaritalStatus"].stringValue, "CountryCode":data["CountryCode"].stringValue]
        
        let header = ["Authorization":"Bearer \(token! as String)","header":"application/json"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Users/UpdateProfile" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:header)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }

    }
    
    public func registerUser(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        print(data)
        let params = ["Email": data["Email"].stringValue,"MobileNo":data["MobileNo"].stringValue, "EmployeeID":data["EmployeeID"].stringValue, "EmployeeNumber":data["EmployeeNumber"].stringValue, "Password":data["Password"].stringValue, "MaritalStatus": data["MaritalStatus"].stringValue, "CountryCode":data["CountryCode"].stringValue]
        let header = ["header":"application/json"]

        print(params)
//        params["Email"].stringValue = data["Email"]
//        params = "Email=\(data["Email"])&EmployeeID=\(data["EmployeeID"])&LastName=\(data["LastName"])&Password=\(data["Password"])&Gender=\(data["Gender"])&EmployeeNumber=\(data["EmployeeNumber"])&FirstName=\(data["FirstName"])&MiddleName=\(data["MiddleName"])&MobileNo=\(data["MobileNo"])&MaritalStatus=\(data["MaritalStatus"])&FullName=\(data["FullName"]),&CountryCode=\(data["CountryCode"])&DateOfBirth=\(data["DateOfBirth"])"
        
                do {
            let opt = try HTTP.POST(apiURL+"Users/Register" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:header)
            opt.start { response in
                if let _ = response.error {
                    print(response.error)
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func premiumConfirm(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/Confirm" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    
    public func AddMembers(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        print(isLoginheader)
        
        let params = ["data": "\(data)"]
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/UpdateMobile" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func ChangeSI(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/ChangeSIMobile" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                //                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func ChangeTU(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/ChangeTopupMobile" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                //                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func ResetPassword(code:String, password:String, confirmPassword:String ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let params = ["Code":code, "newPassword":password, "confirmPassword":confirmPassword]

        let header = ["header":"application/json"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Users/ResetPassword" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:header)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    
    public func EnrolledName(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/Name" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }

    
    public func ConnectSection(data : String ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ConnectSection" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }

    
    public func DashboardDetails(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        print(token)
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/DashboardDetails" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func HospitalSearch(data : JSON, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/DashboardDetails" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func Hospital(location:String, hospital:String  ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        let params = ["Location":location, "Hospital":hospital]
        hospital == ""
        print("heyyaprintthisforme\(location)\(hospital)")
        do {
            let opt = try HTTP.POST(apiURL+"Hospitals/Search" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func getAllEvents(completion:((JSON) -> Void)) {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        let id = defaultToken.stringForKey("clientId")
        
        do {
            let opt = try HTTP.GET(apiURL+"Wellness/Events/\(id!)", parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    } else {
                        completion(json)
                    }
                } else {
                    json  = JSON(data: response.data)
                    completion(json)
                }
            }
        } catch _ {
            completion(json)
        }
    }
    
    public func getEventDetail(id: Int, completion:((JSON) -> Void)) {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Wellness/EventDetails/\(id)", parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    } else {
                        completion(json);
                    }
                } else {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    
    public func getEventRegistration(id: Int, completion:((JSON) -> Void)) {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Wellness/RegisterEvent/\(id)", parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    } else {
                        completion(json);
                    }
                } else {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    
    public func likeEvent(id: Int, type: String, completion:((JSON) -> Void)) {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Wellness/\(type)/\(id)", parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    } else {
                        completion(json);
                    }
                } else {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }

    public func getLocation(address:String, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let url = NSURL(string:address.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        do {
            let opt = try HTTP.GET("https://maps.googleapis.com/maps/api/geocode/json?address=\(url)&key=AIzaSyDAe0p475gZB89bLQUcNRIwkhNzuG2HGFw" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:nil)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }

    public func BenefitSummery(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/MobileBenefitSummery" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }

    
    public func FaqCategories(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"FAQ/Categories" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }

    
    public func FaqDetails(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
//        let params = ["data": "\(data)"]
        print(categoryId)
        
        do {
            let opt = try HTTP.GET(apiURL+"FAQ/Details/\(categoryId)" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    
    public func SendQuery(data: JSON, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["To": data["To"].stringValue,"Subject":data["Subject"].stringValue, "Body":data["Body"].stringValue]
        print(params)
        
        do {
            let opt = try HTTP.POST(apiURL+"FAQ/SendQuery" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
        
    public func ConnectDetails(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ConnectDetails" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }

    
    public func ClaimForm(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ClaimForm" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }


   
    public func SendOtp(mobileno : String!, countrycode : String!, completion:((JSON) -> Void))
    {
            var json = JSON(1)
        do {
            let opt = try HTTP.GET(apiURL + "Users/SendOTP/\(countrycode)/\(mobileno)" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:["header":"application/json"])
            
            opt.start { response in
                if let _ = response.error {
                    completion(json);
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            print("out side ")
            completion(json);
        }
        
    }
    
    
    public func ClientSendOTP(mobileno : String!, password : String!, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        print(apiURL + "Users/ClientSendOTP/\(mobileno)/\(password)")
        do {
            let opt = try HTTP.GET(apiURL + "Users/ClientSendOTP/\(mobileno)/\(password)" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
            
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    print(response.error)
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            print("out side ")
            completion(json);
        }
        
    }
    
    
    public func ConfirmOtp(code : String!, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        print(apiURL + "Users/ConfirmOTP/\(forgotMobileNumber!)/\(code)")
        do {
            let opt = try HTTP.GET(apiURL + "Users/ConfirmOTP/\(forgotMobileNumber)/\(code)" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: nil)
            opt.start { response in
                if let _ = response.error {
                    completion(json);
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
        
    }
    
    public func DownloadECard(ecard : String!, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        do {
            let opt = try HTTP.GET(apiURL + "Users/Ecard/\(ecard)" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: isLoginheader)
            opt.start { response in
                print(response.error)
                if let _ = response.error {
                    completion(json);
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    
    public func isEnrolled(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        if (token != nil) {
            let isLoginheader = ["Authorization":"Bearer \((token)! as String)"]
            do {
                let opt = try HTTP.GET(apiURL + "Enrollments/IsEnrolled" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: isLoginheader)
                opt.start { response in
                    
                    if let _ = response.error {
                        let nsError = response.error! as NSError
                        if nsError.code == 401 {
                            json = JSON(nsError.code)
                            completion(json)
                        }else{
                            completion(json);
                        }
                    }
                    else
                    {
                        json  = JSON(data: response.data)
                        completion(json);
                    }
                }
            } catch _ {
                completion(json);
            }

        }
                   }
    
    public func activeClaims(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        if (token != nil) {
            let isLoginheader = ["Authorization":"Bearer \((token)! as String)"]
            do {
                let opt = try HTTP.GET(apiURL + "EmployeeClaims/PreAuthClaimsMobile" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: isLoginheader)
                opt.start { response in
                    
                    if let _ = response.error {
                        let nsError = response.error! as NSError
                        if nsError.code == 401 {
                            json = JSON(nsError.code)
                            completion(json)
                        }else{
                            completion(json);
                        }
                    }
                    else
                    {
                        json  = JSON(data: response.data)
                        completion(json);
                    }
                }
            } catch _ {
                completion(json);
            }
            
        }
    }

    public func reimbursementClaims(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        if (token != nil) {
            let isLoginheader = ["Authorization":"Bearer \((token)! as String)"]
            do {
                let opt = try HTTP.GET(apiURL + "EmployeeClaims/ReimbusementClaimsMobile" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: isLoginheader)
                opt.start { response in
                    
                    if let _ = response.error {
                        let nsError = response.error! as NSError
                        if nsError.code == 401 {
                            json = JSON(nsError.code)
                            completion(json)
                        }else{
                            completion(json);
                        }
                    }
                    else
                    {
                        json  = JSON(data: response.data)
                        completion(json);
                    }
                }
            } catch _ {
                completion(json);
            }
            
        }
    }
    
    public func messageReimburse(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        if (token != nil) {
            let isLoginheader = ["Authorization":"Bearer \((token)! as String)"]
            do {
                let opt = try HTTP.GET(apiURL + "Claim/PatientList" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: isLoginheader)
                opt.start { response in
                    
                    if let _ = response.error {
                        let nsError = response.error! as NSError
                        if nsError.code == 401 {
                            json = JSON(nsError.code)
                            completion(json)
                        }else{
                            completion(json);
                        }
                    }
                    else
                    {
                        json  = JSON(data: response.data)
                        completion(json);
                    }
                }
            } catch _ {
                completion(json);
            }
            
        }
    }

    
    public func changePassword(cp: String, np: String, cnp: String, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        do {
            let opt = try HTTP.GET(apiURL + "Users/ChangePassword/\(cp)/\(np)/\(cnp)" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers: isLoginheader)
            opt.start { response in
                if let _ = response.error {
                    let nsError = response.error! as NSError
                    if nsError.code == 401 {
                        json = JSON(nsError.code)
                        completion(json)
                    }else{
                        completion(json);
                    }
                }
                else
                {
                    json  = JSON(data: response.data)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    

}




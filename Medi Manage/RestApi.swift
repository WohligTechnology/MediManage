//
//  RestApi.swift
//  MediManage
//9
//  Created by Jagruti Patil on 30/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHTTP
import UIKit
import CoreData
import SystemConfiguration
import Alamofire



let adminUrl = "http://testcorp.medimanage.com/api/";
let apiURL = adminUrl + "v1/";
let defaultToken = NSUserDefaults.standardUserDefaults()

public class RestApi {
        public func findEmployee(empno:String, dob:String, completion:((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["EmpNo":empno, "DOB":dob]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL + "Users/FindEmployee", parameters: params, requestSerializer: JSONParameterSerializer(), headers:["header":"application/json"])
            print(opt)
            opt.start { response in
                if let _ = response.error {
                    completion(json);
                }
                else
                {
                    json  = JSON(data: response.data)
                    print(json)
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
    public func login(username:String, password:String, completion:((JSON) -> Void))  {
        var json = JSON(1);
        print(json)
        let params = ["grant_type": "password","username":username, "password":password]
      
    
        
        
        
      /*  [{"isSelected": "true", "FirstName": "Niruben", "MiddleName": "R", "RelationType": "Wife", "DateOfRelation": "2016-04-01", "SystemIdentifier": "S", "LastName": "Patel", "DateOfBirth": "1975-01-29"},
        "isSelected": "true", "FirstName": "Ravi", "MiddleName": "R", "RelationType": "Son", "DateOfRelation": "null", "SystemIdentifier": "C", "LastName": "Patel", "DateOfBirth": "1997-10-04"]
      
        */
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
          print(json)
        let params = ["grant_type": "password","username":username, "password":password]
        let header = ["Content-Type":"application/x-www-form-urlencoded"]
        
    Manager.request(.POST, adminUrl+"token" ,parameters: params, headers: header)
            .responseJSON { response in
                debugPrint(response)
                json = JSON(data: response.data!)
                //print(json["access_token"])
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
    
    public func findEmployeeProfile(SUBURL : String,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        print("authentication")
        print(isLoginheader)
       
        Manager.request(.GET, apiURL+SUBURL ,parameters: nil, headers: isLoginheader)
            .responseJSON { response in
               // debugPrint(response)
                json = JSON(data: response.data!)
                //print(json["access_token"])
                completion(json)
               // print(json)
                
        }}
    
    public func GetProfile(data : JSON, completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Users/Profile" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    public func UpdateProfile(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
         let params = ["data": "\(data)"]
        do {
            let opt = try HTTP.POST(apiURL+"Users/UpdateProfile" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    public func premiumConfirm(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/Confirm" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    
    public func AddMembers(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/UpdateMobile" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    
    public func ResetPassword(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        do {
            let opt = try HTTP.POST(apiURL+"Users/ResetPassword" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    
    public func EnrolledName(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/Name" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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

    
    public func ConnectSection(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ConnectSection" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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

    
    public func DashboardDetails(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/DashboardDetails" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    public func HospitalSearch(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/DashboardDetails" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    public func ClaimForm(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]

        
        do {
            let opt = try HTTP.GET(apiURL+"Hospitals/Search" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    
    public func BenefitSummery(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/BenefitSummery" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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

    
    public func FaqCategories(completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"FAQ/Categories" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
        
    public func SubmitQuery(data : JSON ,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.stringForKey("access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        do {
            let opt = try HTTP.POST(apiURL+"FAQ/SendQuery" , parameters: params, requestSerializer: JSONParameterSerializer(), headers:isLoginheader)
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
    

   
    public func SendOtp(SUBURL :String,mobileno : String, password : String, completion:((JSON) -> Void))
    {
            var json = JSON(1)
        do {
            let opt = try HTTP.GET(apiURL + SUBURL + "({\(mobileno)}/{\(password)})" , parameters: nil, requestSerializer: JSONParameterSerializer(), headers:["header":"application/json"])
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

}




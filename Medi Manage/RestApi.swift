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



let adminUrl = "https://testcorp.medimanage.com/api/";
let apiURL = adminUrl + "v1/";

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
// ‘Authorization’: ‘Bearer{single space}‘ + api_key

    public func findEmployeeProfile(SUBURL : String,completion:((JSON) -> Void))
    {
        var json = JSON(1)
        
        let header = ["Authorization":"Bearer \(Employee_API_KEY)"]
       
        Manager.request(.GET, apiURL+SUBURL ,parameters: nil, headers: header)
            .responseJSON { response in
               // debugPrint(response)
                json = JSON(data: response.data!)
                //print(json["access_token"])
                completion(json)
                
        }}
    
    
}

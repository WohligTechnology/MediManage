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

let adminUrl = "http://testcorp.medimanage.com/api/";
let apiURL = adminUrl + "v1/";

public class RestApi {
        public func findEmployee(empno:String, dob:String, completion:((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["EmpNo":empno, "DOB":dob]
        print(params)
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
        let params = ["grant_type":"password","username":username, "password":password]
        print(params)
        let header = ["Content-Type":"application/x-www-form-urlencoded"]
        do {
            let opt = try HTTP.POST(adminUrl + "token", parameters: params, requestSerializer: JSONParameterSerializer(), headers:header)
            opt.start { response in
                print(response)
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
                    completion(json);
                }
            }
        } catch _ {
            completion(json);
        }
    }
}


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
let defaultToken = UserDefaults.standard

open class RestApi {
        open func findEmployee(_ empno:String, dob:String, completion:@escaping ((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["EmpNo":empno, "DOB":dob]
        do {
            let opt = try HTTP.POST(apiURL + "Users/FindEmployee", parameters: params, headers:["header":"application/json"], requestSerializer: JSONParameterSerializer())
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
    open func login(_ username:String, password:String, completion:@escaping ((JSON) -> Void))  {
        var json = JSON(1);
        let params = ["grant_type": "password","username":username, "password":password]
            let header = ["Content-Type":"application/x-www-form-urlencoded"]
        
        do {
            let opt = try HTTP.POST(adminUrl + "token", parameters: params, headers:header, requestSerializer: JSONParameterSerializer())
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
                    let defaults = UserDefaults.standard
                    print(json["access_token"])
                    defaults.setValue(String(describing: json["access_token"]), forKey: defaultsKeys.token)
                   // setBool(true, forKey: "loadingOAuthToken")
                    completion(json);
                    
                }
            }
        } catch _ {
            completion(json);
          
    
        }
    }
    
  open func loginAlaomFire(_ username:String, password:String, completion:@escaping ((JSON) -> Void))  {
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

    fileprivate var Manager : Alamofire.Manager = {
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
    
    open func findEmployeeProfile(_ SUBURL : String,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        var isLoginheader = [String:String]()
        let token = defaultToken.string(forKey: "access_token")
        if token != nil {
             isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        }
        print(token)
        
        do {
            let opt = try HTTP.GET(apiURL+SUBURL , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func GetProfile(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Users/Profile" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func UpdateProfile(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        print("data to params")
        print(data)
        let params = ["Email": data["Email"].stringValue,"MobileNo":data["MobileNo"].stringValue, "EmployeeID":data["EmployeeID"].stringValue, "EmployeeNumber":data["EmployeeNumber"].stringValue, "Password":data["Password"].stringValue, "MaritalStatus": data["MaritalStatus"].stringValue, "CountryCode":data["CountryCode"].stringValue]
        
        let header = ["Authorization":"Bearer \(token! as String)","header":"application/json"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Users/UpdateProfile" , parameters: params, headers:header, requestSerializer: JSONParameterSerializer())
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
    
    open func registerUser(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        print(data)
        let params = ["Email": data["Email"].stringValue,"MobileNo":data["MobileNo"].stringValue, "EmployeeID":data["EmployeeID"].stringValue, "EmployeeNumber":data["EmployeeNumber"].stringValue, "Password":data["Password"].stringValue, "MaritalStatus": data["MaritalStatus"].stringValue, "CountryCode":data["CountryCode"].stringValue]
        let header = ["header":"application/json"]

        print(params)
//        params["Email"].stringValue = data["Email"]
//        params = "Email=\(data["Email"])&EmployeeID=\(data["EmployeeID"])&LastName=\(data["LastName"])&Password=\(data["Password"])&Gender=\(data["Gender"])&EmployeeNumber=\(data["EmployeeNumber"])&FirstName=\(data["FirstName"])&MiddleName=\(data["MiddleName"])&MobileNo=\(data["MobileNo"])&MaritalStatus=\(data["MaritalStatus"])&FullName=\(data["FullName"]),&CountryCode=\(data["CountryCode"])&DateOfBirth=\(data["DateOfBirth"])"
        
                do {
            let opt = try HTTP.POST(apiURL+"Users/Register" , parameters: params, headers:header, requestSerializer: JSONParameterSerializer())
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
    
    open func premiumConfirm(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/Confirm" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    
    open func AddMembers(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        print(isLoginheader)
        
        let params = ["data": "\(data)"]
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/UpdateMobile" , parameters: params, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func ChangeSI(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/ChangeSIMobile" , parameters: params, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func ChangeTU(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["data": "\(data)"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Enrollments/ChangeTopupMobile" , parameters: params, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func ResetPassword(_ code:String, password:String, confirmPassword:String ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        
        let params = ["Code":code, "newPassword":password, "confirmPassword":confirmPassword]

        let header = ["header":"application/json"]
        print(params)
        do {
            let opt = try HTTP.POST(apiURL+"Users/ResetPassword" , parameters: params, headers:header, requestSerializer: JSONParameterSerializer())
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
    
    
    open func EnrolledName(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/Name" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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

    
    open func ConnectSection(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ConnectSection" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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

    
    open func DashboardDetails(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        print(token)
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/DashboardDetails" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func HospitalSearch(_ data : JSON ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/DashboardDetails" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func Hospital(_ data : String ,completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Hospitals/Search/\(data)" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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

    open func getLocation(_ address:String, completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let url = URL(string:address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        do {
            let opt = try HTTP.GET("https://maps.googleapis.com/maps/api/geocode/json?address=\(url)&key=AIzaSyDAe0p475gZB89bLQUcNRIwkhNzuG2HGFw" , parameters: nil, headers:nil, requestSerializer: JSONParameterSerializer())
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

    open func BenefitSummery(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/MobileBenefitSummery" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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

    
    open func FaqCategories(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"FAQ/Categories" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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

    
    open func FaqDetails(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
//        let params = ["data": "\(data)"]
        print(categoryId)
        
        do {
            let opt = try HTTP.GET(apiURL+"FAQ/Details/\(categoryId)" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    
    open func SendQuery(_ data: JSON, completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        let params = ["To": data["To"].stringValue,"Subject":data["Subject"].stringValue, "Body":data["Body"].stringValue]
        print(params)
        
        do {
            let opt = try HTTP.POST(apiURL+"FAQ/SendQuery" , parameters: params, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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
        
    open func ConnectDetails(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ConnectDetails" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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

    
    open func ClaimForm(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        
        do {
            let opt = try HTTP.GET(apiURL+"Enrollments/ClaimForm" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
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


   
    open func SendOtp(_ mobileno : String!, countrycode : String!, completion:@escaping ((JSON) -> Void))
    {
            var json = JSON(1)
        do {
            let opt = try HTTP.GET(apiURL + "Users/SendOTP/\(countrycode)/\(mobileno)" , parameters: nil, headers:["header":"application/json"], requestSerializer: JSONParameterSerializer())
            
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
    
    
    open func ClientSendOTP(_ mobileno : String!, password : String!, completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        print(apiURL + "Users/ClientSendOTP/\(mobileno)/\(password)")
        do {
            let opt = try HTTP.GET(apiURL + "Users/ClientSendOTP/\(mobileno)/\(password)" , parameters: nil, headers:isLoginheader, requestSerializer: JSONParameterSerializer())
            
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
    
    
    open func ConfirmOtp(_ code : String!, completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        print(apiURL + "Users/ConfirmOTP/\(forgotMobileNumber!)/\(code)")
        do {
            let opt = try HTTP.GET(apiURL + "Users/ConfirmOTP/\(forgotMobileNumber)/\(code)" , parameters: nil, headers: nil, requestSerializer: JSONParameterSerializer())
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
    
    open func DownloadECard(_ ecard : String!, completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        do {
            let opt = try HTTP.GET(apiURL + "Users/Ecard/\(ecard)" , parameters: nil, headers: isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func isEnrolled(_ completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        let token = defaultToken.string(forKey: "access_token")
        if (token != nil) {
            let isLoginheader = ["Authorization":"Bearer \((token)! as String)"]
            do {
                let opt = try HTTP.GET(apiURL + "Enrollments/IsEnrolled" , parameters: nil, headers: isLoginheader, requestSerializer: JSONParameterSerializer())
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
    
    open func changePassword(_ cp: String, np: String, cnp: String, completion:@escaping ((JSON) -> Void))
    {
        var json = JSON(1)
        
        let token = defaultToken.string(forKey: "access_token")
        let isLoginheader = ["Authorization":"Bearer \(token! as String)"]
        do {
            let opt = try HTTP.GET(apiURL + "Users/ChangePassword/\(cp)/\(np)/\(cnp)" , parameters: nil, headers: isLoginheader, requestSerializer: JSONParameterSerializer())
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




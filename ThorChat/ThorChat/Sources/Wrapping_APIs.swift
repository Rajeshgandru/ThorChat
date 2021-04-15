//
//  Wrapping_APIs.swift
//  Flower Bazaaar Seller
//
//  Created by Thorsignia on 10/08/20.
//  Copyright © 2020 Thorsignia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Toast_Swift

let Str_Global_CustomerID                             = "CustomerID"
let Str_Global_Mobilenumber                           = "Mobilenumber"

enum UserValidationState {
    case valid
    case invalid(String)
}
extension UIViewController {
    func ShowAlert(message : String){
        let alertController = UIAlertController(title: kAppTitle, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

class Wrapping_APIs: NSObject{
    static func APIRequest
    (urlString:String,Method:HTTPMethod,headers:HTTPHeaders,parameter:Parameters,completion:@escaping (_ status:Bool,_ response:JSON,_ message:String) ->()){
        isNetworkAvailable { (status, message) in
            if status{
                let url = URL(string:"\(urlString)")!
                print(url)
                print("headers \(headers)")
                print("parameter passing \(parameter)")
                let manager = Alamofire.Session.default
                manager.session.configuration.timeoutIntervalForRequest = 10
                switch Method{
                case .post:
                    manager.request(url, method:Method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                        print(response)
                        responseData(response: response, completion: { (status,response,message) in
                            completion(status,response,message)
                        })
                    }
                case.get:
                    manager.request(url, method:Method, parameters: parameter, headers: headers).responseJSON { (response) in
                        print(response)
                        responseData(response: response, completion: { (status,response,message) in
                            completion(status,response,message)
                        })
                    }
                case .put:
                    manager.request(url, method:Method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                        print(response)
                        responseData(response: response, completion: { (status,response,message) in
                            completion(status,response,message)
                        })
                    }
                case .delete:
                    manager.request(url, method:Method, parameters: parameter, headers: headers).responseJSON { (response) in
                        print(response)
                        responseData(response: response, completion: { (status,response,message) in
                            completion(status,response,message)
                        })
                    }
                default:
                    break
                }
            }else{
                completion(false,"",message)
            }
        }
    }
}

//Get Response as String
func GetStringfromDictinary(key:String,responseAny:AnyObject) -> String
{
    let responseString =  (responseAny as AnyObject).value( forKeyPath: key )!
    return responseString as! String
}

func responseData(response : AFDataResponse<Any>, completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        
    }
    let statusCode = response.response?.statusCode
    if statusCode == 200{
        switch(response.result)
        {
        case .success(let value):
            let resJson = JSON(value)
            completion(true,resJson,"")
            break
        case .failure(_):
            switch response.error!._code {
            case NSURLErrorTimedOut:
                completion(false,"Failure","Network error")
                break
            case NSURLErrorNotConnectedToInternet:
                completion(false,"Failure","Check your internet connection")
                break
            default:
                completion(false,"Failure","Network error")
                break
            }
            break
        }
    }else if statusCode == 300 {
        completion(false,"Failure","Token not found(Please Login again!")
    }else if statusCode == 301{
        switch(response.result){
        case .success(_):
            completion(true,"Success","")
            break
        case .failure(_):
            completion(false,"Failure","Please try again later")
            break
        }
    }else if statusCode == 302{
        switch(response.result){
        case .success(_):
            completion(false,"Failure","")
            break
        case .failure(_):
            completion(false,"Failure","Please try again later")
            break
        }
    }else if statusCode == 400{
        switch(response.result){
        case .success(_):
            completion(false,"Failure","msg")
            break
        case .failure(_):
            completion(false,"Failure","Please try again later")
            break
        }
    }else if statusCode == 500{
        print("invalid password")
        completion(false,"Failure","Something went wrong")
    }else if statusCode == 404{
        completion(false,"Failure","No data available")
    }else if statusCode == 401{
        
    }else{
        completion(false,"Failure",(response.error?.localizedDescription) ?? "")
    }
}




//********************************** API_CITY_LIST ************************************
func API_CITY_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(CustomerID)
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.CITY_API, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Home_Data_LIST ************************************

func API_Home_Data_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Get_Home_data_API_1)
    print(headers)
    print(paramater)
    //       Wrapping_APIs.APIRequest(urlString: Constants.URLs.Get_Home_data_API, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
    //           print(status,response,message)
    //           completion(status,response,message)
    //       }
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.Get_Home_data_API_1, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Filter_Data_LIST ************************************

func API_Filter_Data_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Get_Filter_data_API)
    print(headers)
    print(paramater)
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.Get_Filter_data_API, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}
//********************************** API_Sub_Catogory_Home_Data_LIST ************************************

func API_Sub_Catogory_Home_Data_LIST(type :String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(headers)
    print(paramater)
    var UrlString = ""
    if type == "0" {
        print(Constants.URLs.Get_All_SubCategory_Home_data_API)
        
        UrlString = Constants.URLs.Get_All_SubCategory_Home_data_API
    }else {
        print(Constants.URLs.Get_SubCategory_Home_data_API + type)
        
        UrlString = Constants.URLs.Get_SubCategory_Home_data_API + type
    }
    Wrapping_APIs.APIRequest(urlString: UrlString, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Sub_Catogory_Colors_Data_LIST ************************************

func API_Sub_Catogory_Colors_Data_LIST(SubCategoryId :String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(CustomerID)
    
    print(Constants.URLs.Get_All_SubCategory_Colour_data_API + SubCategoryId)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.Get_All_SubCategory_Colour_data_API + SubCategoryId, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}


//********************************** API_LogIN ************************************

func API_LogIN(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.LogIN_API)
    print(headers)
    print(paramater)
    
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.LogIN_API , Method: HTTPMethod.post,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_LogOut ************************************

func API_LogOut(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.LogOUT_API)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.LogOUT_API, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Register ************************************

func API_Register(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.OtpVerification)
    print(headers)
    print(paramater)
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.OtpVerification , Method: HTTPMethod.post,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Resend_OTP ************************************

func API_Resend_OTP(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.ResendOtp + CustomerID)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.ResendOtp + CustomerID , Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}


//********************************** Customer_Edit_Personal_Address_Details_Capturing_API ************************************

func Customer_Edit_Personal_Address_Details_Capturing_API(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.EditAddressDetails)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.EditAddressDetails , Method: HTTPMethod.post,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Search_Products ************************************

func API_Search_Products(PageNumber :String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Search_Product_data_API + PageNumber)
    print(headers)
    print(paramater)
    
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.Search_Product_data_API + PageNumber, Method: HTTPMethod.post,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_CountCart_Method ************************************

func API_CountCart_Method(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.CartCountAPI)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.CartCountAPI, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}


//********************************** API_Seller_Shop_Product_Bysearch_List ************************************

func API_Seller_Shop_Product_Bysearch_List(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SellerShopSelectedProductListBySearchword)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.SellerShopSelectedProductListBySearchword, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Seller_Shop_Product_List ************************************

func API_Seller_Shop_Product_List(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SellerShopSelectedProductList)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.SellerShopSelectedProductList, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Search_Via_Search_Screen_Products ************************************

func API_Search_Via_Search_Screen_Products(PageNumber :String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Search_Product_WithSearchScreen_API + PageNumber)
    print(headers)
    print(paramater)
    
    
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.Search_Product_WithSearchScreen_API + PageNumber, Method: HTTPMethod.post,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}
//********************** API_SellerShopsugitionsList_LIST**********************
func API_SellerShopsugitionsList_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Search_SellerShop_Suggestion_API)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.Search_SellerShop_Suggestion_API, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_sugitionsList_LIST ************************************
func API_sugitionsList_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Search_Suggestion_API)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.Search_Suggestion_API, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}


//********************************** API_ProductPreview_Data_LIST ************************************

func API_ProductPreview_Data_LIST(CityId:String,seller_product_listing_history_id : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
//    var CityID : Int = 0
//    if UserDefaults.standard.value(forKey: Str_Global_CityId) != nil{
//        CityID = (UserDefaults.standard.value(forKey: Str_Global_CityId) as? Int)!
//    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    
    
    
    let additionaurl = "customer_id=\(CustomerID)&seller_product_listing_history_id=\(seller_product_listing_history_id)&city_id=\(CityId)"
    
    print(Constants.URLs.ProductPreview + additionaurl)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.ProductPreview + additionaurl, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}






//***************************** API_SellerShopSubCategoryVerityDetails_Data_LIST ************************************

func API_SellerShopSubCategoryVerityDetails_Data_LIST(SubcategoryID:String,categoryID : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    //    var CityID : Int = 0
    //    if UserDefaults.standard.value(forKey: Str_Global_CityId) != nil{
    //        CityID = (UserDefaults.standard.value(forKey: Str_Global_CityId) as? Int)!
    //    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    
    
    var ApiName = String()
//    if categoryID == "1" || categoryID == "0" {
//        ApiName = Constants.URLs.BASE_URL +  "get/seller/active/subcategory/variety/list/by/subcategory/for/customer"
//    }else if categoryID == "2" {
        ApiName = Constants.URLs.BASE_URL +  "get/seller/active/subcategory/variety/list/by/subcategory/for/customer"
//    }else if categoryID == "3" {
//
//    }else if categoryID == "4" {
//
//    }
    print(ApiName)
    print(headers)
    print(paramater)
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: ApiName, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
}

//***************************** API_AddingSameItemToTheCartAgainApiCalling ************************************

func API_AddingSameItemToTheCartAgainApiCalling(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    //    var CityID : Int = 0
    //    if UserDefaults.standard.value(forKey: Str_Global_CityId) != nil{
    //        CityID = (UserDefaults.standard.value(forKey: Str_Global_CityId) as? Int)!
    //    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(CustomerID)
    
    print(Constants.URLs.AddAgainSameProductToCart)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.AddAgainSameProductToCart, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
}
//***************************** API_AddingItemToTheCartApiCalling_LIST ************************************

func API_AddingItemToTheCartApiCalling_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    //    var CityID : Int = 0
    //    if UserDefaults.standard.value(forKey: Str_Global_CityId) != nil{
    //        CityID = (UserDefaults.standard.value(forKey: Str_Global_CityId) as? Int)!
    //    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.AddProductToCart)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.AddProductToCart, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
}
//********************************** API_GetAllCatogiryListSellerShop_Data_LIST ************************************

func API_GetAllCatogiryListSellerShop_Data_LIST(sellerid : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    
    let additionaurl =  "customer_id=\(CustomerID)&seller_id=\(sellerid)"
    print(Constants.URLs.SellerShopAllCategorysDetailsgetApi + additionaurl)
    print(headers)
    print(paramater)
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.SellerShopAllCategorysDetailsgetApi + additionaurl, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}
//********************************** API_Get_Seller_Shop_Details_Data_LIST ************************************

func API_Get_Seller_Shop_Details_Data_LIST(sellerId : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    //    var CityID : Int = 0
    //          if UserDefaults.standard.value(forKey: Str_Global_CityId) != nil{
    //             CityID = (UserDefaults.standard.value(forKey: Str_Global_CityId) as? Int)!
    //          }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    
    let additionaurl = "customer_id=\(CustomerID)&seller_id=\(sellerId)"
    
    print(Constants.URLs.SellerShopDetailsgetApi + additionaurl)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.SellerShopDetailsgetApi + additionaurl, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Saved_Address_Data_LIST ************************************


func API_Saved_Address_Data_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(CustomerID)
    
    print(Constants.URLs.SavedAddress  + CustomerID)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.SavedAddress  + CustomerID, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Get_Fevarate_Product_LIST ************************************


func API_Get_Fevarate_Product_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.FevarateProducts  + CustomerID)
    print(headers)
    print(paramater)
    
    
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.FevarateProducts  + CustomerID, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Get_Fevarate_Seller_LIST ************************************


func API_Get_Fevarate_Seller_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.FevarateSellers  + CustomerID)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.FevarateSellers  + CustomerID, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}
//********************************** API_Mark_As_Default_Address_LIST ************************************


func API_Mark_As_Default_Address_LIST(addressid : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.MarkAsDefaultAddress  + CustomerID + "&customer_address_id=" +  addressid)
    print(headers)
    print(paramater)
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.MarkAsDefaultAddress  + CustomerID + "&customer_address_id=" +  addressid, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_Delete_Address_LIST ************************************


func API_Delete_Address_LIST(addressid : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.DeleteAddress  + CustomerID + "&customer_address_id=" +  addressid)
    print(headers)
    print(paramater)
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.DeleteAddress  + CustomerID + "&customer_address_id=" +  addressid, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}

//********************************** API_GetMyOrdersDetailsMethod ************************************


func API_GetMyOrdersDetailsMethod(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.MyorderDetailsAPI)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.MyorderDetailsAPI, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_GetFAQDetailsMethod_Method ************************************


func API_GetFAQDetailsMethod_Method(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.getFAQListDetailsApi)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.getFAQListDetailsApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_GETFAQ_LIST_Method ************************************


func API_GETFAQ_LIST_Method(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.getFAQListApi)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.getFAQListApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}
//********************************** API_GetSellerAllReviews_LIST ************************************


func API_GetSellerAllReviews_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SellerRatingAndReviews)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.SellerRatingAndReviews, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}
//********************************** API_ReOpen_Ticket ************************************


func API_ReOpen_Ticket(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.ReOpenTicketApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.ReOpenTicketApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_Give FeedBackTo existing Ticket ************************************


func API_GiveFeedBackToExistingTicket(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GiveFeedBackToExistingTicketApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GiveFeedBackToExistingTicketApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}


//********************************** API_GetRaisedTicket_LIST ************************************


func API_GetRaisedTicket_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.RaiseTicketListApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.RaiseTicketListApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}


//********************************** API_GetSupportDetailsMethod_LIST ************************************


func API_GetSupportDetailsMethod_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.getsupportandPoliciesDetailsApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.getsupportandPoliciesDetailsApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_RatingsAndReviews_LIST ************************************


func API_RatingsAndReviews_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.MyBillsListAPI)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.RatingsAndReviewsList, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_MYBillsListModel_LIST ************************************


func API_MYBillsListModel_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.MyBillsListAPI)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.MyBillsListAPI, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}
//********************************** API_SubMitSellerRating_LIST ************************************


func API_SubMitSellerRating_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.getFeedBackSellersRatingSubmit)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.getFeedBackSellersRatingSubmit, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_SellersFromCities_LIST ************************************


func API_SellersFromCities_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SellersFromCities_API)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.SellersFromCities_API, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_GetFeedBackAndSellers_LIST ************************************


func API_GetFeedBackAndSellers_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.getFeedBackSellersList)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.getFeedBackSellersList, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}

//********************************** API_MYOrdersListModel_LIST ************************************


func API_MYOrdersListModel_LIST(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.MyorderListAPI)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.MyorderListAPI, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    
}
//********************************** API_Delete_ProfilePic_LIST ************************************


func API_Delete_ProfilePic_LIST(addressid : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.DeleteProfilePic)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.DeleteProfilePic, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
    
    
    //    Wrapping_APIs.APIRequest(urlString: Constants.URLs.DeleteProfilePic  + CustomerID, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
    //           print(status,response,message)
    //           completion(status,response,message)
    //       }
}

//********************************** API_Add_Fevarate_Seller_LIST ************************************


func API_Add_Fevarate_Seller_LIST(mark_status_seller :String,sellerID : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.Addfevorateseller  + CustomerID + "&seller_id=" +  sellerID + "&mark_status_seller=" + mark_status_seller)
    print(headers)
    print(paramater)
    
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.Addfevorateseller  + CustomerID + "&seller_id=" +  sellerID + "&mark_status_seller=" + mark_status_seller, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}//********************************** API_Add_Fevarate_Seller_Product_LIST ************************************


func API_Add_Fevarate_Seller_Product_LIST(mark_status :String,sellerID : String,ProductID:String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.AddfevoratesellerProduct  + CustomerID + "&seller_id=" +  sellerID + "&seller_product_listing_id=" + ProductID + "&mark_status=" + mark_status)
    print(headers)
    print(paramater)
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.AddfevoratesellerProduct  + CustomerID + "&seller_id=" +  sellerID + "&seller_product_listing_id=" + ProductID + "&mark_status=" + mark_status, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}
//********************************** API_Saved_Address_Details_Data_LIST ************************************


func API_Saved_Address_Details_Data_LIST(customer_address_id : String,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SavedAddressDetails  + CustomerID + "&customer_address_id=" + customer_address_id)
    print(headers)
    print(paramater)
    
    
    Wrapping_APIs.APIRequest(urlString: Constants.URLs.SavedAddressDetails  + CustomerID + "&customer_address_id=" + customer_address_id, Method: HTTPMethod.get,headers: headers, parameter: paramater){ (status, response, message) in
        print(status,response,message)
        completion(status,response,message)
    }
}
//********************************** API_AcceptingCalling ************************************

func API_AcceptingCalling(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.AcceptingAudioVideoCall)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.AcceptingAudioVideoCall, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_EndCallAudio_VideoCall ************************************

func API_EndCallAudio_VideoCall(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.EndAudioVideoCall)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.EndAudioVideoCall, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_GetAudio_VideoCallTokens ************************************

func API_GetAudio_VideoCallTokens(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetAudioVideoCallToken)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetAudioVideoCallToken, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Get_Chat_Details ************************************

func API_Get_Chat_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetChatDetails)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetChatDetails, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Update_Profile_Details ************************************

func API_Update_Profile_Details(ProfileImg :UIImage,paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.UpdateProfileFullDetails)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                multipartFormData.append(ProfileImg.jpegData(compressionQuality: 0.01)!, withName: "customer_profile_photo",fileName: "customer_profile_photo", mimeType: "jpg/png/jpeg")
            }, to: Constants.URLs.UpdateProfileFullDetails, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Get_Profile_Details ************************************

func API_Get_Profile_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetProfileFullDetails)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetProfileFullDetails, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Get_Cart_Details ************************************

func API_Get_Cart_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetCartDetailsApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetCartDetailsApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//************************** API_Back_from_Product_Summary_Details ************************************

func API_Back_from_Product_Summary_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetBackFromProductSummaryApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetBackFromProductSummaryApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Product_Summary_Details ************************************

func API_Product_Summary_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetProductSummaryApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetProductSummaryApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_GetRewardsListApiMethod_Calling ************************************

func API_GetRewardsListApiMethod_Calling(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetCurrentRewardsTransList)
    print(headers)
    print(paramater)
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetCurrentRewardsTransList, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_GetOffersApiMethodCalling ************************************

func API_GetOffersApiMethodCalling(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetCurrentUserOffers)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetCurrentUserOffers, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Redeem_Btn_Method ************************************

func API_Redeem_Btn_Method(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetRedeemApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetRedeemApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Place_Order_Method ************************************

func API_Place_Order_Method(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.PlaceOrderDetailsSaveInSeverApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.PlaceOrderDetailsSaveInSeverApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_select_Payment_Method ************************************

func API_select_Payment_Method(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SelectPaymentMethodApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.SelectPaymentMethodApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_EditgetCartDeatils ************************************

func API_EditgetCartDeatils(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.EditCartDetailsApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.EditCartDetailsApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_getReferralCodeCintent_Details ************************************

func API_getReferralCodeCintent_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetReferrelCodeApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetReferrelCodeApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_DeliveryStatusChangeApiCalling_Details ************************************

func API_DeliveryStatusChangeApiCalling_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.MyorderStatusChangeAPI)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.MyorderStatusChangeAPI, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Cancel_Item_From_Myorders_Details ************************************

func API_Cancel_Item_From_Myorders_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.CancelMyorderAPI)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.CancelMyorderAPI, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Remove_Item_From_Cart_Details ************************************

func API_Remove_Item_From_Cart_Details(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.RemoveAllProductsFromCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.RemoveAllProductsFromCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_RemoveSingleItemApiCalling ************************************

func API_RemoveSingleItemApiCalling(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.RemoveSingleProductsFromCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.RemoveSingleProductsFromCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_EditSingleItemApiCalling ************************************

func API_EditSingleItemApiCalling(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.EditSingleProductsFromCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.EditSingleProductsFromCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_Get_Conformation_For_SingleProduct_InCart ************************************

func API_Get_Conformation_For_SingleProduct_InCart(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.GetConformationForProductINCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.GetConformationForProductINCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}


//********************************** API_PlaceOrder_For_SingleProduct_InCart ************************************

func API_PlaceOrder_For_SingleProduct_InCart(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.PlaceOrderForSingleProductINCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.PlaceOrderForSingleProductINCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_Mode_Of_transportation_ToCart ************************************

func API_Mode_Of_transportation_ToCart(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.ModeOfTransportationCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.ModeOfTransportationCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//********************************** API_PlaceOrder_For_MultipulProduct_InCart ************************************

func API_PlaceOrder_For_MultipulProduct_InCart(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.PlaceOrderForMultiPuleProductINCartApi)
    print(headers)
    print(paramater)
    
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.PlaceOrderForMultiPuleProductINCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}

//********************************** API_QwickView_InCart ************************************

func API_QwickView_InCart(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.QwickViewApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.QwickViewApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}


//**************************** API_SubMitModeOfTransportation_InCart ************************************

func API_SubMitModeOfTransportation_InCart(paramater: Parameters,completion:@escaping (_ status:Bool,_ response:JSON, _ message:String) -> ()){
    var CustomerID : String = ""
    if UserDefaults.standard.value(forKey: Str_Global_CustomerID) != nil{
        CustomerID = (UserDefaults.standard.value(forKey: Str_Global_CustomerID) as? String)!
    }
    var client_service : String = ""
    if UserDefaults.standard.value(forKey: "client_service") != nil{
        client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
    }
    var auth_key : String = ""
    if UserDefaults.standard.value(forKey: "auth_key") != nil{
        auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
    }
    let headers: HTTPHeaders = ["Content-Type":"application/json",
                                "Client-Service":client_service,
                                "Auth-Key":auth_key]
    print(Constants.URLs.SaveModeOftransportationCartApi)
    print(headers)
    print(paramater)
    
    isNetworkAvailable { (status, message) in
        if status{
            AF.session.configuration.timeoutIntervalForRequest = 10
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in paramater {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }, to: Constants.URLs.SaveModeOftransportationCartApi, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
            }.responseJSON { (response) in
                print(response)
                responseData(response: response, completion: { (status,response,message) in
                    completion(status,response,message)
                })
            }
            
        }else {
            completion(false,"",message)
        }
    }
}
//--------------------------------------------------------------------------------------
//--------------------- MARK:- Check network availability ------------------------------
//--------------------------------------------------------------------------------------
func isNetworkAvailable(completionHandler:@escaping (_ success:Bool, _ message:String) -> ())
{
    let reachability = NetworkReachabilityManager()
    let status = reachability?.status
    
    switch status {
    case .notReachable?:
        completionHandler(false,"check_Your_Internet_Connection")
        print("The network is not reachable")
        
    case .unknown? :
        completionHandler(false,"notReachable")
        print("It is unknown whether the network is reachable")
    // not sure what to do for this case
    case .reachable(.ethernetOrWiFi)?:
        completionHandler(true,"wifi")
        print("The network is reachable over the WiFi connection")
    case .reachable(.cellular)?:
        completionHandler(true,"mobilen_w")
        print("The network is reachable over the WWAN connection")
    case .none:
        break
        
    }
}

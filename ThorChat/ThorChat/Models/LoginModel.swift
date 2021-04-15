//
//  LoginModel.swift
//  InterviewApp
//
//  Created by rajesh gandru on 23/09/20.
//

import Foundation
import ObjectMapper
import Alamofire
import UIKit

class LoginModel :Codable,Mappable {
    
    var status = 0
    var message = ""
    var customer_id = "0"
    var customer_otp = "0"
    required init?(map: Map) {}
    init() {}
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        customer_id <- map["customer_id"]
        customer_otp <- map["customer_otp"]
    }
    
}



class RegisterModel :Codable,Mappable {
    
    var status = 0
    var message = ""
    var redirectTo = ""
    var client_service = ""
    var auth_key = ""
    
    required init?(map: Map) {}
    init() {}
    func mapping(map: Map) {
        
        status <- map["status"]
        client_service <- map["client_service"]
        message <- map["message"]
        redirectTo <- map["redirectTo"]
        auth_key <- map["auth_key"]
    }
    
}


//{
//    "status": 200,
//    "message": "Cities List",
//    "citiesList": [
//        {
//            "city_id": "1",
//            "city_name": "Bombuflat",
//            "state_id": "1",
//            "state_name": "Andaman and Nicobar Islands",
//            "country_id": "101",
//            "sortname": "IN",
//            "country_name": "India",
//            "phonecode": "91"
//        },
//        {
//            "city_id": "2",
//            "city_name": "Garacharma",
//            "state_id": "1",
//            "state_name": "Andaman and Nicobar Islands",
//            "country_id": "101",
//            "sortname": "IN",
//            "country_name": "India",
//            "phonecode": "91"
//        }
//     ]
//}
//class citiesList :Codable,Mappable {

class citiesList_Model :Codable,Mappable {
    //    var state_id = ""
    //    var state_name = ""
    //    var country_id = ""
    //    var city_id = ""
    //    var city_name = ""
    
    var city_id = ""
    var city_name = ""
    var state_id = ""
    var state_name = ""
    var country_id = ""
    var sortname = ""
    var country_name = ""
    var phonecode = ""
    required init?(map: Map) {}
    init() {}
    func mapping(map: Map) {
        
        //        state_id <- map["state_id"]
        //        state_name <- map["state_name"]
        //        country_id <- map["country_id"]
        //        city_id <- map["city_id"]
        //        city_name <- map["city_name"]
        
        city_id  <- map["city_id"]
        city_name  <- map["city_name"]
        state_id  <- map["state_id"]
        state_name  <- map["state_name"]
        country_id  <- map["country_id"]
        sortname  <- map["sortname"]
        country_name  <- map["country_name"]
        phonecode  <- map["phonecode"]
    }
    
}

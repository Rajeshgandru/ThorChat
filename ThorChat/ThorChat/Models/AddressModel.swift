//
//  AddressModel.swift
//  FlowerBazaaarCustomer
//
//  Created by Thorsignia on 08/10/20.
//  Copyright © 2020 Thorsignia. All rights reserved.
//

import Foundation
import ObjectMapper


class SavedAddressModel  : NSObject, Mappable{
    var status : Int?
    var message : String?
    var customerAddressList : [SavedAddressCustomerAddressList]?
    
    override init() {}
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        message <- map["message"]
        customerAddressList <- map["customerAddressList"]
    }
    
}
class SavedAddressCustomerAddressList  : NSObject, Mappable{
    var customer_address_id : String?
    var fullAddress : String?
    var customer_name_address : String?
    var customer_address_type : String?
    var customer_address_mobile : String?
    var customer_primary_address : String?
    var customer_id : String?
    
    override init() {}
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        
        customer_address_id <- map["customer_address_id"]
        fullAddress <- map["fullAddress"]
        customer_name_address <- map["customer_name_address"]
        customer_address_type <- map["customer_address_type"]
        customer_address_mobile <- map["customer_address_mobile"]
        customer_primary_address <- map["customer_primary_address"]
        customer_id <- map["customer_id"]
    }
    
}
class GetAddressDeatilsModel   : NSObject, Mappable{
    var status : Int?
    var message : String?
    var customerAddressDtls : GetAddressCustomerAddressDtls?
    
    override init() {}
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        
        
        status <- map["status"]
        message <- map["message"]
        customerAddressDtls <- map["customerAddressDtls"]
    }
    
}



class GetAddressCustomerAddressDtls   : NSObject, Mappable{
    var customer_address_id : String?
    var customer_id : String?
    var customer_name_address : String?
    var customer_address : String?
    var city_id : String?
    var state_id : String?
    var customer_landmark : String?
    var customer_pincode : String?
    var customer_address_type : String?
    var customer_address_mobile_number_verified : String?
    var customer_address_mobile : String?
    var customer_address_email : String?
    var customer_primary_address : String?
    var customer_address_created_at : String?
    var customer_address_updated_at : String?
    var state_name : String?
    var state_code : String?
    var country_id : String?
    var city_name : String?
    var city_code : String?
    var city_logo : String?
    
    override init() {}
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        
        
        customer_address_id <- map["customer_address_id"]
        customer_id <- map["customer_id"]
        customer_name_address <- map["customer_name_address"]
        customer_address <- map["customer_address"]
        city_id <- map["city_id"]
        state_id <- map["state_id"]
        customer_landmark <- map["customer_landmark"]
        customer_pincode <- map["customer_pincode"]
        customer_address_type <- map["customer_address_type"]
        customer_address_mobile_number_verified <- map["customer_address_mobile_number_verified"]
        customer_address_mobile <- map["customer_address_mobile"]
        customer_address_email <- map["customer_address_email"]
        customer_primary_address <- map["customer_primary_address"]
        customer_address_created_at <- map["customer_address_created_at"]
        customer_address_updated_at <- map["customer_address_updated_at"]
        state_name <- map["state_name"]
        state_code <- map["state_code"]
        country_id <- map["country_id"]
        city_name <- map["city_name"]
        city_code <- map["city_code"]
        city_logo <- map["city_logo"]
    }
    
}

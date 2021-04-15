//
//  PhoneNumberVerificationVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit
import CountryPickerView
import ObjectMapper
class PhoneNumberVerificationVC: UIViewController,CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    //MARK:-  -- ****************** -- 
    //MARK:-  -- Class IBOutlets  -- 
    @IBOutlet weak var countryPickerViewref: CountryPickerView!
    @IBOutlet weak var countryNameLbelref:UILabel!
    @IBOutlet weak var countryCodeLblref: UILabel!
    @IBOutlet weak var mobileNumberTFref: UITextField!
    
    //MARK:-  -- ****************** -- 
    //MARK:-  -- CLASS PROPERTIES -- 
    
    
    //MARK:-  -- ****************** -- 
    //MARK:-  -- Class View lyfe Cycle -- 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryPickerViewref.delegate = self
        self.countryPickerViewref.dataSource = self
        self.countryPickerViewref.countryDetailsLabel.isHidden = true
        self.countryPickerViewref.flagImageView.isHidden = true
        self.countryNameLbelref.text = countryPickerViewref.selectedCountry.name
        self.countryCodeLblref.text = countryPickerViewref.selectedCountry.phoneCode
        self.mobileNumberTFref.delegate = self
    }
    
    //MARK:-  -- ****************** -- 
    //MARK:-  -- Button Actions Starts here... -- 
    @IBAction func Submitbtnref(_ sender: Any) {
        // TODO: - 👊 Validations -
        switch validateSignupCredentials {
        case .valid:
            LoginApiCalling()
        case .invalid(let message):
            self.ShowAlert(message: message)
        }
        
//        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
//        //nxtVC.mobileNumber = countryCode + " " + mobileNumber
//        //nxtVC.CustomerID = customerID
//        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
}
extension PhoneNumberVerificationVC {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country){
        self.countryNameLbelref.text = country.name
        self.countryCodeLblref.text = country.phoneCode
    }
    
}
//MARK:-  -- ****************** -- 
//MARK:-  -- Login screen Validation -- 
extension PhoneNumberVerificationVC {
    var validateSignupCredentials:UserValidationState {
        if self.mobileNumberTFref.text?.isEmpty == true {
            return .invalid("Please enter your number")
        }else if self.mobileNumberTFref.text?.count ?? 0 < 10 || self.mobileNumberTFref.text?.count ?? 0 > 10 {
            return .invalid("Please enter valid number")
        }
        return .valid
    }
}

//MARK:-  -- ****************** -- 
//MARK:-  -- Class Api Calling... -- 
extension PhoneNumberVerificationVC {
    //MARK:- Get Submit Login  Api Calling...
    func LoginApiCalling(){
        let bar = PUGIFLoading()
        guard let mobileNumber = self.mobileNumberTFref.text else {
            return
        }
        guard let countryCode = self.countryCodeLblref.text else {
            return
        }
        
        bar.show("", gifimagename: "Spinner")
        var parameters = [String:Any]()
        
        parameters = ["customer_mobile_number": countryCode + mobileNumber,"customer_fcm_token" : newDeviceId,"customer_device_type":"IOS","push_kit_token_for_buyer":myPushKitToken]
        
        API_LogIN(paramater: parameters)
        { (status, response, message) in
            if status == true{
                
                var check :  LoginModel?
                check = Mapper<LoginModel>().map(JSON:response.dictionaryObject!)
                if check?.status == 200{
                    
                    
                    if let customerID = check?.customer_id {
                        //                        let dicMessage = [
                        //                            "customer_mobile_number" : "+91" + customer_mobile_number,
                        //                            "customer_fcm_token" : newDeviceId,
                        //                            "customer_device_type" :"IOS",
                        //                            "push_kit_token_for_buyer":myPushKitToken,
                        //                            "buyer_id":check?.customer_id
                        //                        ]
                        //                        if  customerID  != nil || customerID != ""{
                        //                            // self.ref.child(Str_Global_FireBase_single_Device_Login).child(customerID).childByAutoId().setValue(dicMessage)
                        //
                        //
                        //                            self.ref.child(Str_Global_FireBase_single_Device_Login).observeSingleEvent(of: .value, with: { (snapshot) in
                        //                                if snapshot.hasChild(customerID){
                        //                                    Database.database().reference().child(Str_Global_FireBase_single_Device_Login).child(customerID).removeValue()
                        //
                        //                                    self.ref.child(Str_Global_FireBase_single_Device_Login).child(customerID).childByAutoId().setValue(dicMessage)
                        //                                    print("true rooms exist")
                        //
                        //                                }else{
                        //                                    self.ref.child(Str_Global_FireBase_single_Device_Login).child(customerID).childByAutoId().setValue(dicMessage)
                        //                                    print("false room doesn't exist")
                        //                                }
                        //
                        //
                        //                            })
                        //                        }
                        
                        UserDefaults.standard.set(countryCode + mobileNumber, forKey: Str_Global_Mobilenumber)
                        UserDefaults.standard.set(check?.customer_id ?? "0", forKey: Str_Global_CustomerID)
                        
                        
                        
                        
                        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
                        nxtVC.mobileNumber = countryCode + " " + mobileNumber
                        nxtVC.CustomerID = customerID
                        self.navigationController?.pushViewController(nxtVC, animated: true)
                    }
                    
                    bar.hide()
                }else if check?.status == 204{
                    bar.hide()
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 400{
                    bar.hide()
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 401{
                    bar.hide()
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 403{
                    bar.hide()
                    self.ShowAlert(message: check?.message ?? "somethingWentWrong")
                }
            }else{
                if message == "theRequestTimedOut" || message == "notReachable"{
                    bar.hide()
                    self.view.makeToast("pleaseCheckYourInternetSignal_Is_Too_Low", duration: 2.0, position: .center)
                }else if message == "check_Your_Internet_Connection" {
                    bar.hide()
                    self.view.makeToast("please_Check_Your_Internet", duration: 2.0, position: .center)
                }else{
                    bar.hide()
                    self.view.makeToast("somethingWentWrong", duration: 2.0, position: .center)
                }
            }
        }
    }
    
}
//MARK:-  -- ****************** -- 
//AMRK:-  -- Textfeild Delegate calling... -- 
extension PhoneNumberVerificationVC  : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 10
    }
}

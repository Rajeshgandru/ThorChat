//
//  EditMyProfileVC.swift
//  FlowerBazaaarCustomer
//
//  Created by Thorsignia on 21/10/20.
//  Copyright © 2020 Thorsignia. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON
import Foundation
class EditMyProfileVC: UIViewController {
    
    //MARK:-  -- Class IBOutlets  -- 
    @IBOutlet weak var Nametfref: UITextField!
    @IBOutlet weak var Userimgref: UIImageView!
   
    
    //MARK:-  -- CLASS PROPERTIES -- 
    // Username,UserNumber,UserPhotoUrl,userId -- this we are taking from previous screen
    // for showing content to edit
    var Username = String()
    var UserNumber = String()
    var UserPhotoUrl = String()
    var userId = String()
    // selected user profile picture we are store in this property , for compressing 200kb
    var selectedImge = UIImage()
    var imageselected = false
    
    //MARK:-  -- Class View lyfe Cycle -- 
    //Method -- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        //Laoding content to ui screen , which we taken from previous screen...
//        self.Userimgref.sd_setImage(with: URL(string: self.UserPhotoUrl ?? ""), placeholderImage: UIImage(named: "UserDefaultLogo"))
        self.Nametfref.text = self.Username
        
    }
    
    //MARK:-  -- Class Button actions Starts here... -- 
    
    
    
    // Add new Profile btn action...
    // Alert action sheet we are showing with this btn...
    @IBAction func AddProfileBtnref(_ sender: Any) {
//        let alert = UIAlertController(title: kAppTitle, message: "Please Select an Option", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
//            print("User click Edit button")
//            ImagePickerManager().pickImage(self, false){ (image,Document,IsDocumentType,filestr) in
//                self.imageselected = true
////                self.selectedImge = image
////                self.Userimgref.image =  image
//
//                 self.selectedImge = image!.resized(toWidth: 72.0)!
//                 self.Userimgref.image = image!.resized(toWidth: 72.0)
//
////                let resizedImage = image.resizedTo1MB()
////
////                self.selectedImge = resizedImage!
////                self.Userimgref.image = resizedImage
//            }
            
            
            ImagePickerManager().pickImage(self, false){ (image,Document,IsDocumentType,filestr) in
                if let image = image!.resized(toWidth: 1000.0) {
                   self.selectedImge = image
                    self.Userimgref.image = image
 
                    self.imageselected = true
                }
                 
               
            }
       // }))
//        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
//            print("User click Delete button")
//            self.DeleteProfilepicMthod()
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
//            print("User click Dismiss button")
//        }))
//        self.present(alert, animated: true, completion: {
//            print("completion block")
//        })
    }
    
    // Submit to edit datails to server...
    // With validation...
    @IBAction func Submitbtnref(_ sender: Any) {
        if Nametfref.text != "" {
            self.EditUserProfileMethod()
        }else {
            self.ShowAlert(message: "Please add your name")
        }
    }
    // Update mobile number...
    // cureently its pending...
    // uninstall position in storyboard...
    @IBAction func Updatebtnref(_ sender: Any) {
    }
    
}

//MARK:-  -- Class Api Calling... -- 
extension EditMyProfileVC {
    //MARK:-  -- Update Profile Details... -- 
    func EditUserProfileMethod(){
        let bar = PUGIFLoading()
        bar.show("", gifimagename: "Spinner")
        guard let CustomerID = UserDefaults.standard.string(forKey: Str_Global_CustomerID) else{
            bar.hide()
            return
        }
        
 

        var parameters = [String:Any]()
        parameters = [
            "customer_id": CustomerID,
            "customer_name" : self.Nametfref.text ?? ""
        ]
        
        var seller_id : Int!
        if UserDefaults.standard.value(forKey: "seller_id") != nil{
            seller_id = Int((UserDefaults.standard.value(forKey: "seller_id") as? String)!)
        }
        
        var client_service : String = ""
        if UserDefaults.standard.value(forKey: "client_service") != nil{
            client_service = (UserDefaults.standard.value(forKey: "client_service") as? String)!
        }
        var auth_key : String = ""
        if UserDefaults.standard.value(forKey: "auth_key") != nil{
            auth_key = (UserDefaults.standard.value(forKey: "auth_key") as? String)!
        }
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>",
            "Client-Service":client_service,
            "Auth-Key":auth_key,
        ]
        
        guard let currentDatestr = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .full, timeStyle: .full).removeWhitespace() as? String else{return}

        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if self.imageselected {
                multipartFormData.append(self.selectedImge.jpegData(compressionQuality:0.1)!, withName:"customer_profile_photo", fileName: "\(currentDatestr).jpeg", mimeType: "image/jpeg")
            }
            
        }, to: Constants.URLs.UpdateProfileFullDetails, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
        }
        .response { (response) in
            if response.response?.statusCode == 200 {
                let json = response.data
                if (json != nil){
                    bar.hide()
                    
                    let jsonObject = JSON(json!)
                    var check :  LoginModel?
                    check = Mapper<LoginModel>().map(JSON:jsonObject.dictionaryObject!)
                    if check?.status == 200{
                        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
                        let storyboard = UIStoryboard(name: "DashBoard", bundle: nil)
                        let main = storyboard.instantiateViewController(withIdentifier: "DashBoardTabVC") as! DashBoardTabVC
                        main.selectedIndex = 3
                        appDelegate?.window?.rootViewController = main
                        appDelegate?.window?.makeKeyAndVisible()
                    }else if check?.status == 204{
                        self.view.makeToast(check?.message, duration: 2.0, position: .center)
                    }else if check?.status == 400{
                        self.view.makeToast(check?.message, duration: 2.0, position: .center)
                    }else if check?.status == 401{
                        self.view.makeToast(check?.message, duration: 2.0, position: .center)
                    }else if check?.status == 403{
                        self.ShowAlert(message: check?.message ?? "somethingWentWrong")
                    }
                }
            } else {
                bar.hide()
                self.view.makeToast("somethingWentWrong", duration: 2.0, position: .center)
            }
        }
    }
  
    
    //MARK:-   -- Delete Profile Pic method Api Calling... -- 
    func DeleteProfilepicMthod(){
        let bar = PUGIFLoading()
        bar.show("", gifimagename: "Spinner")
        
        guard let CustomerID = UserDefaults.standard.string(forKey: Str_Global_CustomerID) else{
            bar.hide()
            return
        }
        let parameters = ["customer_id":CustomerID]
        
        API_Delete_ProfilePic_LIST(addressid :"",paramater: parameters)
        { (status, response, message) in
            if status == true{
                var check :  SavedAddressModel?
                check = Mapper<SavedAddressModel>().map(JSON:response.dictionaryObject!)
                if check?.status == 200{
                    //SavedAddressListArr
                    
                    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
                    let storyboard = UIStoryboard(name: "DashBoard", bundle: nil)
                    let main = storyboard.instantiateViewController(withIdentifier: "DashBoardTabVC") as! DashBoardTabVC
                    main.selectedIndex = 3
                    appDelegate?.window?.rootViewController = main
                    appDelegate?.window?.makeKeyAndVisible()
                    bar.hide()
                    
                    
                }else if check?.status == 204{
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                    bar.hide()
                }else if check?.status == 400{
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                    bar.hide()
                }else if check?.status == 401{
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                    bar.hide()
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


extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
  }

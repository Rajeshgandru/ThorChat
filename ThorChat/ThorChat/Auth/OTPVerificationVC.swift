//
//  OTPVerificationVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit
import ObjectMapper
class OTPVerificationVC: UIViewController {

    @IBOutlet weak var vpmOtpViewref: VPMOTPView!
    @IBOutlet weak var resendbtnref: UIButton!
    @IBOutlet weak var resendCallbtnref: UIButton!
    @IBOutlet weak var mobileNumberlblref: UILabel!
    @IBOutlet weak var timerLblref: UILabel!
    
    //Previous Screen Entered MobileNumber
    var mobileNumber = ""
    var CustomerID = ""
    
    //Timer Initalisation...
    var timer = Timer()
    //Otp String...
    var enteredOtp: String = ""
    //Maximum otp timer limit...
    var sessionTimer = 60//120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mobileNumberlblref.text = mobileNumber
        self.OtpValidationInit()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backbtnref(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ResendOtpbtnref(_ sender: Any) {
        self.resendbtnref.isHidden = true
        // TODO: - 👊 Validations -
        switch validateSignupCredentials {
        case .valid:
            self.REsendOtpValidation()
        case .invalid(let message):
            self.ShowAlert(message: message)
        }
    }
    
    @IBAction func CallMebtnref(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "EditMyProfileVC") as! EditMyProfileVC
         self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    func verifybtnref() {
       // TODO: - 👊 Validations -
       if enteredOtp.count < 4 {
           self.ShowAlert(message: "Please enter valid otp")
       }else {
           sendOtpValidation()
       }
   }
    
 
}

//MARK:-  -- ****************** -- 
//MARK:-  -- OTP Validation -- 
extension OTPVerificationVC {
    func OtpValidationInit(){
        //Mobile number disaply...
        //self.mobilenumblblref.text = verification_code_sent + "\(mobilenumber)"
        //OTP View Seting up UI view...
        vpmOtpViewref.otpFieldsCount = 4
        vpmOtpViewref.otpFieldDefaultBorderColor = UIColor.blue
        vpmOtpViewref.otpFieldEnteredBorderColor = UIColor.green
        vpmOtpViewref.otpFieldErrorBorderColor = UIColor.red
        vpmOtpViewref.otpFieldBorderWidth = 0
        vpmOtpViewref.otpFieldDisplayType = .circular
        vpmOtpViewref.otpFieldDefaultBackgroundColor = UIColor(named: "#F3F3F3")!
        vpmOtpViewref.otpFieldEnteredBackgroundColor = UIColor(named: "#F3F3F3")!
        vpmOtpViewref.delegate = self
        vpmOtpViewref.shouldAllowIntermediateEditing = false
        
        // Create the UI for otp
        vpmOtpViewref.initializeUI()
        //Intially we are hiding resend btn...
        self.resendbtnref.isHidden = true
        self.timerLblref.isHidden = true
        //timer start over here...
        start()
    }
}

//MARK:-  -- ****************** -- 
//MARK:-  -- OTP Validation -- 
extension OTPVerificationVC {
    var validateSignupCredentials:UserValidationState {
        if self.mobileNumberlblref.text?.isEmpty == true {
            return .invalid("Something went Wrong")
        }
        return .valid
    }
}
//MARK:-  -- ****************** -- 
//MARK:-  -- Otp View Delegate Implimentation -- 
extension OTPVerificationVC: VPMOTPViewDelegate {
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        
        return enteredOtp == "12345"
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        enteredOtp = otpString
        self.verifybtnref()
        print("OTPString: \(otpString)")
    }
    //MARK:-  -- ****************** -- 
    //MARK:-  -- timer Implimentation -- 
    //MARK:-  -- timer Functions -- 
    func start(){
        if(self.timer.isValid == false) {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true)
            
        }
        //selectedIndex = 0
    }
    @objc func action(){
        if sessionTimer > 0 {
            sessionTimer -= 1
            let watch = StopWatch(totalSeconds: sessionTimer)
            self.resendbtnref.isHidden = true
            self.timerLblref.isHidden = false
            self.timerLblref.text =  "Resend code in " + watch.simpleTimeString
            //self.resendCallbtnref.setTitle("Call me in " + watch.simpleTimeString, for: .selected)
        }else {
            pause()
            self.resendbtnref.isHidden = false
            self.timerLblref.isHidden = true
            self.resendbtnref.setTitle("Resend code", for: .normal)
            self.resendCallbtnref.setTitle("Call me", for: .normal)
        }
    }
    func pause() {
        self.timer.invalidate()
    }
}
//MARK:-  -- ****************** -- 
//MARK:-  -- Class Api Calling... -- 
extension OTPVerificationVC {
    //MARK:-  -- ****************** -- 
    //MARK:-  -- Send OTP for Validaion Api Calling... -- 
    func sendOtpValidation(){
        let bar = PUGIFLoading()
        bar.show("", gifimagename: "Spinner")
         var parameters = [String:Any]()
        parameters = ["customer_id":self.CustomerID,"customer_otp":enteredOtp]
        
        API_Register(paramater: parameters)
        { (status, response, message) in
            if status == true{
                bar.hide()
                var check :  RegisterModel?
                check = Mapper<RegisterModel>().map(JSON:response.dictionaryObject!)
                if check?.status == 200{
                    if let authKey = check?.auth_key{
                        UserDefaults.standard.set(authKey, forKey: "auth_key")
                    }
                    if let client_Service = check?.client_service {
                        UserDefaults.standard.set(client_Service, forKey: "client_service")
                    }
                    
                    UserDefaults.standard.set(true, forKey: "Str_Global_IsUserLogIned")
                    let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nxtVC = Storyboard.instantiateViewController(withIdentifier: "EditMyProfileVC") as! EditMyProfileVC
                    self.navigationController?.pushViewController(nxtVC, animated: true)

                    
                }else if check?.status == 204{
                    self.vpmOtpViewref.initializeUI()
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 400{
                    self.vpmOtpViewref.initializeUI()
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 401{
                    self.vpmOtpViewref.initializeUI()
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 403{
                    self.vpmOtpViewref.initializeUI()
                    bar.hide()
                    self.ShowAlert(message: check?.message ?? "somethingWentWrong")
                }else if check?.status == 422 {
                    self.vpmOtpViewref.initializeUI()
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
    
    //MARK:-  -- ****************** -- 
    //MARK:-  -- click Resend otp Api Calling... -- 
    func REsendOtpValidation(){
        let bar = PUGIFLoading()
        bar.show("", gifimagename: "Spinner")
        let parameters = [String:Any]()
        API_Resend_OTP(paramater: parameters)
        { (status, response, message) in
            if status == true{
                bar.hide()
                var check :  LoginModel?
                check = Mapper<LoginModel>().map(JSON:response.dictionaryObject!)
                if check?.status == 200{
                    self.sessionTimer = 60
                    self.resendbtnref.isHidden = true
                    self.start()
                    if let otp_str =  check?.customer_otp{
                        //                        if otp_str.count > 0 {
                        //                            self.ShowAlert(message: otp_str)
                        //                        }
                    }
                    
                }else if check?.status == 204{
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 400{
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 401{
                    self.view.makeToast(check?.message, duration: 2.0, position: .center)
                }else if check?.status == 403{
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

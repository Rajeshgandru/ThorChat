//
//  OTPVerificationVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit

class OTPVerificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backbtnref(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ResendOtpbtnref(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
         self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    @IBAction func CallMebtnref(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
         self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
 
}

//
//  PhoneNumberVerificationVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit

class PhoneNumberVerificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Submitbtnref(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
         self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
}

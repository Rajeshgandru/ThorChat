//
//  LounchScreenVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit

class LounchScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func agreeContinueBtnref(_ sender: Any) {
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "PhoneNumberVerificationVC") as! PhoneNumberVerificationVC
        self.navigationController?.pushViewController(nxtVC, animated: true)
        
    }
    
    @IBAction func policyBtnref(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "TermaAndPolicyVC") as! TermaAndPolicyVC
        nxtVC.titleStr = "Privacy Policy"
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    @IBAction func termaBtnref(_ sender: Any) {
        
       
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "TermaAndPolicyVC") as! TermaAndPolicyVC
        nxtVC.titleStr = "Terms of Services"
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
}

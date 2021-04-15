//
//  EditProfileVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit

class EditProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func moveToDashBoardbtnref(_ sender: Any) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "DashBoard", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "DashBoardTabVC") as! DashBoardTabVC
        main.selectedIndex = 3
        appDelegate?.window?.rootViewController = main
        appDelegate?.window?.makeKeyAndVisible()
    }
    
}

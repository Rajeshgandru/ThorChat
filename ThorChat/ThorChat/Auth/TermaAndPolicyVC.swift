//
//  TermaAndPolicyVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit

class TermaAndPolicyVC: UIViewController {

    @IBOutlet weak var titleLblref: UILabel!
    
    var titleStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLblref.text = titleStr
        // Do any additional setup after loading the view.
    }
    

    @IBAction func BackBtnref(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

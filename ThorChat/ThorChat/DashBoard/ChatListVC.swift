//
//  DashBoardVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit

class ChatListCell: UITableViewCell{
    
    @IBOutlet weak var imageRef: UIImageView!
    @IBOutlet weak var titleLblref: UILabel!
    
    @IBOutlet weak var separatorLblref: UILabel!
    
}
class ChatListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 

}
extension ChatListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatListCell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        
        return cell
    }
    
    
}

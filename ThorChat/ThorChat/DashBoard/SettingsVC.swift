//
//  SettingsVC.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit
struct SettingsObjects {

       var sectionName : String!
       var sectionObjects : [SettingsData]!
   }
struct SettingsData {
    var name :String
    var Image: UIImage
}

class SettingsCell: UITableViewCell{
    
    @IBOutlet weak var imageRef: UIImageView!
    @IBOutlet weak var titleLblref: UILabel!
    
    @IBOutlet weak var separatorLblref: UILabel!
    
}

class SettingsVC: UIViewController {
    
 
    var objectArray = [SettingsObjects]()
    
   // var settingsArr :[String : SettingsData] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        for i in 0...3 {
            if i == 0 {
                objectArray.append(SettingsObjects(sectionName: "first", sectionObjects: [SettingsData(name: "Starred Messages", Image: #imageLiteral(resourceName: "userLogo")),SettingsData(name: "WhatsApp Web/Desktop", Image: #imageLiteral(resourceName: "userLogo"))]))
            }else if i == 1 {
                objectArray.append(SettingsObjects(sectionName: "second", sectionObjects: [SettingsData(name: "WhatsApp Web/Desktop", Image: #imageLiteral(resourceName: "userLogo")),SettingsData(name: "Chats", Image: #imageLiteral(resourceName: "userLogo")),SettingsData(name: "Notifications", Image: #imageLiteral(resourceName: "userLogo")),SettingsData(name: "Payments", Image: #imageLiteral(resourceName: "userLogo")),SettingsData(name: "Storage and Data", Image: #imageLiteral(resourceName: "userLogo"))]))
            }else if i == 2 {
                objectArray.append(SettingsObjects(sectionName: "third", sectionObjects: [SettingsData(name: "Help", Image: #imageLiteral(resourceName: "userLogo")),SettingsData(name: "Tell a Friend", Image: #imageLiteral(resourceName: "userLogo"))]))
            }
        }
        // Do any additional setup after loading the view.
    }
    


}
extension SettingsVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40.0))
        vw.backgroundColor = .clear
        vw.borderWidthV = 0.5
        vw.borderColorV = #colorLiteral(red: 0.8478390574, green: 0.8479818702, blue: 0.8478202224, alpha: 1)
        
        return vw
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsCell =  tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        cell.titleLblref.text = objectArray[indexPath.section].sectionObjects[indexPath.row].name
        cell.imageRef.image = objectArray[indexPath.section].sectionObjects[indexPath.row].Image
        if objectArray[indexPath.section].sectionObjects.count - 1 == indexPath.row {
            cell.separatorLblref.isHidden = true
        }else {
            cell.separatorLblref.isHidden = false
        }
         return cell
    }
}

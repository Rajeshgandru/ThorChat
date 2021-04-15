//
//  AppDelegate.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import UIKit
import CoreData


var myPushKitToken = ""
var newDeviceId = ""
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NavigationScreens()
        return true
    }


    func NavigationScreens(){
        if UserDefaults.standard.bool(forKey: "Str_Global_IsUserLogIned") {
             let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "DashBoard", bundle: nil)
            let main = storyboard.instantiateViewController(withIdentifier: "DashBoardTabVC") as! DashBoardTabVC
            main.selectedIndex = 3
            appDelegate?.window?.rootViewController = main
            appDelegate?.window?.makeKeyAndVisible()
            
        }else {
            
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : LounchScreenVC = mainStoryboard.instantiateViewController(withIdentifier: "LounchScreenVC") as! LounchScreenVC
            if let navigationController = self.window?.rootViewController as? UINavigationController
            {
                navigationController.pushViewController(initialViewControlleripad, animated: false)
                // window?.rootViewController = initialViewControlleripad
            }
            else
            {
                print("Navigation Controller not Found")
            }
        }
        window?.makeKeyAndVisible()
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ThorChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


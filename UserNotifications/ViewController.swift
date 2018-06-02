//
//  ViewController.swift
//  UserNotifications
//
//  Created by Anshu Vij on 02/06/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. REQUEST PERMISSION
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {
            (granted, error) in
            
            if granted {
                print("Notification Access granted")
            }
            else
            {
                print(error?.localizedDescription)
            }
            
        })
    }

    @IBAction func notificationSet(_ sender: Any) {
        
        scheduleNotification(inSeconds: 5, completion: {sucess in
            if sucess {
                print("Successly schdueled notifications")
            }
            else
            {
                print("Error scheduling notification")
            }
        })
        
    }
    
    func scheduleNotification (inSeconds : TimeInterval , completion : @escaping (_ Success : Bool) -> ())
    {
        // Add an attachment
        
        let myImage = "batman"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "png")
         else
        {
            completion(false)
            return
        }
        
        var attachment : UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "My notification", url: imageURL, options: .none)
        
        
        let notif = UNMutableNotificationContent()
        //only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        notif.title = "New Notfication"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed off!"
        notif.attachments = [attachment]
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "My notification", content: notif, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil
            {
                print(error)
                completion(false)
            }
            else
            {
                completion(true)
            }
        })
    }
    
    
    
    
}


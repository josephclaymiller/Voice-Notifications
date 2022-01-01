//
//  Notification.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 1/1/22.
//

import Foundation
import UIKit

class Notification {
    static var all: [Notification] = []
    static let notificationCenter = UNUserNotificationCenter.current()
    
    var title: String
    var body: String
//    var voice
    var seconds: TimeInterval
    
    init(title: String, body: String, seconds: TimeInterval) {
        self.title = title
        self.body = body
        self.seconds = seconds
        createNotification()
        Notification.all.append(self)
    }
    
//    func createNotification(title: String, body: String, minutes: Int = 1) {
//        createNotification(title: title, body: body, seconds: minutes * 60)
//    }
    
    func createNotification() {
        print(#function)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
    //        content.sound = UNNotificationSound.default
//        let notificatinSoundFileName = UNNotificationSoundName(rawValue: SoundManager.shared.audioFileName)
    //        print(notificatinSoundFileName)
//        content.sound = UNNotificationSound(named: notificatinSoundFileName)
//        print(content.sound)
        content.sound = UNNotificationSound.default
        
        // Configure the recurring date.
    //        var dateComponents = DateComponents()
    //        dateComponents.calendar = Calendar.current
    //        dateComponents.weekday = day  // Tuesday
    //        dateComponents.hour = hour    // 14:00 hours
           
        // Create the trigger as a repeating event.
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        Notification.notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
               print("Could not create notification")
           }
        }
    }

}

// MARK: - Notifications

